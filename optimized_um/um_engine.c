#include "um_engine.h"
#include "um_util.h"

UM um;

static inline void op_conditional_move(Um_register ra, Um_register rb,
                                                            Um_register rc)
{
    if (um.registers[rc] != 0) {
        um.registers[ra] = um.registers[rb];
    }
}

static inline void op_segmented_load(Um_register ra, Um_register rb, Um_register rc)
{
    // Retrieve the segment
    Segment segment = (Segment) Seq_get(um.mapped, um.registers[rb]);
    uint32_t *words = segment->words;

    // Load the specified value into ra
    um.registers[ra] = words[um.registers[rc]];
}

static inline void op_segmented_store(Um_register ra, Um_register rb, Um_register rc)
{
    // Retrieve the segment
    Segment segment = (Segment) Seq_get(um.mapped, um.registers[ra]);
    uint32_t *words = segment->words;

    // Store the specific value
    words[um.registers[rb]] = um.registers[rc];
}

static inline void op_addition(Um_register ra, Um_register rb, Um_register rc)
{
    um.registers[ra] = (um.registers[rb] + um.registers[rc]) % MAX_VAL;
}

static inline void op_multiplication(Um_register ra, Um_register rb, Um_register rc)
{
      um.registers[ra] = (um.registers[rb] * um.registers[rc]) % MAX_VAL;
}

static inline void op_division(Um_register ra, Um_register rb, Um_register rc)
{
      um.registers[ra] = um.registers[rb] / um.registers[rc];
}

static inline void op_bitwise_NAND(Um_register ra, Um_register rb, Um_register rc)
{
      um.registers[ra] = ~(um.registers[rb] & um.registers[rc]);
}

static inline void op_map_segment(Um_register rb, Um_register rc)
{
    // Allocate the memory for the segment
    uint32_t *real_memory = malloc(sizeof(uint32_t) * um.registers[rc]);
    assert(real_memory != NULL);

    // Initialize each word to 0
    for (uint32_t i = 0; i < um.registers[rc]; i++) {
        real_memory[i] = 0;
    }

    Segment updated_segment;

    // Assign to the lowest free index in mapped
    uint32_t id;
    if (Seq_length(um.unmapped) > 0){
        id = (uint32_t)(uintptr_t)Seq_remlo(um.unmapped);
        updated_segment = (Segment) Seq_get(um.mapped, id);
    } else {
        updated_segment = malloc(sizeof(*updated_segment));
        assert(updated_segment != NULL);
        id = Seq_length(um.mapped);
        Seq_addhi(um.mapped, (void *) updated_segment);
    }
    updated_segment->length = um.registers[rc];
    updated_segment->words = real_memory;

    um.registers[rb] = id;
}

static inline void op_unmap_segment(Um_register rc)
{
    // Free the segment memory
    Segment segment = (Segment) Seq_get(um.mapped, um.registers[rc]);
    free(segment->words);
    segment->length = 0;
    segment->words = NULL;

    // Add the id to unmapped
    Seq_addhi(um.unmapped, (void *)(uintptr_t)um.registers[rc]);
}

static inline void op_output(Um_register rc)
{
    // Print as unsigned char
    printf("%c", um.registers[rc]);
}

static inline void op_input(Um_register rc)
{
    // Take input from stdin
    int input = getc(stdin);
    if (input == -1) {
        uint32_t value = 0;
        value = ~value;
        um.registers[rc] = value;
    } else {
        um.registers[rc] = input;
    }
}

static inline void op_load_program(Um_register rb, Um_register rc)
{
    // Set the instructions counter
    um.counter = um.registers[rc];

    // Check the loaded program is not m[0]
    if (um.registers[rb] == 0) {
        return;
    }

    // Retrieve the instructions segment
    Segment instructions_segment = (Segment) Seq_get(um.mapped, 0);
    free(instructions_segment->words);

    // Retrieve the segment to duplicate
    Segment load_from = (Segment) Seq_get(um.mapped, um.registers[rb]);

    // Create new words segment
    uint32_t *new_words = malloc(load_from->length * sizeof(uint32_t));
    assert(new_words != NULL);


    // Copy words in the segment
    for (uint32_t i = 0; i < load_from->length; i++)  {
        new_words[i] = (load_from->words)[i];
    }

    // Update instructions segments fields
    instructions_segment->length = load_from->length;
    instructions_segment->words = new_words;
}

static inline void op_load_value(Um_register ra, uint32_t value)
{
    um.registers[ra] = value;
}

Except_T Bitpack_Overflow = { "Overflow packing bits" };

static inline uint64_t shl(uint64_t word, unsigned bits)
{
        assert(bits <= 64);
        if (bits == 64)
                return 0;
        else
                return word << bits;
}

/*
 * shift R logical
 */
static inline uint64_t shr(uint64_t word, unsigned bits)
{
        assert(bits <= 64);
        if (bits == 64)
                return 0;
        else
                return word >> bits;
}

static inline bool Bitpack_fitsu(uint64_t n, unsigned width)
{
        assert(width <= 64);
        /* thanks to Jai Karve and John Bryan  */
        /* clever shortcut instead of 2 shifts */
        return shr(n, width) == 0;
}

static inline uint64_t Bitpack_getu(uint64_t word, unsigned width, unsigned lsb)
{
        assert(width <= 64);
        unsigned hi = lsb + width; /* one beyond the most significant bit */
        assert(hi <= 64);
        /* different type of right shift */
        return shr(shl(word, 64 - hi),
                   64 - width);
}

/****************************************************************/
static inline uint64_t Bitpack_newu(uint64_t word, unsigned width, unsigned lsb,
                      uint64_t value)
{
        assert(width <= 64);
        unsigned hi = lsb + width; /* one beyond the most significant bit */
        assert(hi <= 64);
        if (!Bitpack_fitsu(value, width))
                RAISE(Bitpack_Overflow);
        return shl(shr(word, hi), hi)                 /* high part */
                | shr(shl(word, 64 - lsb), 64 - lsb)  /* low part  */
                | (value << lsb);                     /* new part  */
}

#define SEGMENT_HINT 65536

void initialize_um ();
void read_instructions (FILE *fp);
void execute_instructions ();
void free_um ();

void run_um (FILE *file) {

    initialize_um();
    // Read in the initial instructions
    read_instructions(file);

    // Loop through execution
    execute_instructions();

    // Free the UM emulator
    free_um();
}

void initialize_um () {

    // Instruction counter
    um.counter = 0;

    // Array for registers
    for(int i = 0; i < NUM_REGISTERS; i++){
        um.registers[i] = 0;
    }

    // Sequences for segments
    um.mapped = Seq_new(SEGMENT_HINT);
    assert(um.mapped != NULL);
    um.unmapped = Seq_new(SEGMENT_HINT);
    assert(um.unmapped != NULL);

}

void read_instructions (FILE *fp) {

    // Create sequence to hold the instructions
    Seq_T instructions = Seq_new(10000);

    // Read in the instructions, bitpack them, add them to the sequence
    while (true) {
        // EOF: break
        int c = fgetc(fp);
        if (c == -1) {
            break;
        } else {
            ungetc(c, fp);
        }
        // Read and bitpack the word
        Um_instruction word = 0;
        for (int i = 24; i >= 0 ; i -= 8) {
            int byte = fgetc(fp);
            word = Bitpack_newu(word, 8, i, byte);
        }
        Seq_addhi(instructions, (void *)(uintptr_t)word);
    }

    // Create segment representing the program
    Segment segment0 = malloc(sizeof(*segment0));
    assert(segment0 != NULL);
    segment0->length = Seq_length(instructions);

    // Create words array with length of sequence
    uint32_t *words = malloc(sizeof(uint32_t) * segment0->length);
    assert(words != NULL);
    segment0->words = words;

    // Copy the values in the sequence to the words array
    for (uint32_t i = 0; i < segment0->length; i++) {
        words[i] = (uint32_t)(uintptr_t)Seq_get(instructions, i);
    }

    // Store segment as m[0]
    Seq_addhi(um.mapped, (void *) segment0);

    Seq_free(&instructions);
}

void execute_instructions () {

    Um_register ra = -1;
    Um_register rb = -1;
    Um_register rc = -1;

    Segment instruction_segment = (Segment) Seq_get(um.mapped, 0);
    uint32_t *instructions = instruction_segment->words;
    Um_instruction cur_instruction = 0;
    int opcode = -1;
    bool doLoop = true;
    // Loop through each instruction
    while (doLoop) {

        // Retrieve the current instruction
        cur_instruction = instructions[um.counter];

        // Retrieve the opcode
        opcode = Bitpack_getu(cur_instruction, 4, 28);

        // Execute the corresponding instruction
        switch(opcode){
          case CMOV:
              ra = Bitpack_getu(cur_instruction, 3, 6);
              rb = Bitpack_getu(cur_instruction, 3, 3);
              rc = Bitpack_getu(cur_instruction, 3, 0);
              op_conditional_move(ra, rb, rc);
              break;
          case SLOAD:
              ra = Bitpack_getu(cur_instruction, 3, 6);
              rb = Bitpack_getu(cur_instruction, 3, 3);
              rc = Bitpack_getu(cur_instruction, 3, 0);
              op_segmented_load(ra, rb, rc);
              break;
          case SSTORE:
              ra = Bitpack_getu(cur_instruction, 3, 6);
              rb = Bitpack_getu(cur_instruction, 3, 3);
              rc = Bitpack_getu(cur_instruction, 3, 0);
              op_segmented_store(ra, rb, rc);
              break;
          case ADD:
              ra = Bitpack_getu(cur_instruction, 3, 6);
              rb = Bitpack_getu(cur_instruction, 3, 3);
              rc = Bitpack_getu(cur_instruction, 3, 0);
              op_addition(ra, rb, rc);
              break;
          case MUL:
              ra = Bitpack_getu(cur_instruction, 3, 6);
              rb = Bitpack_getu(cur_instruction, 3, 3);
              rc = Bitpack_getu(cur_instruction, 3, 0);
              op_multiplication(ra, rb, rc);
              break;
          case DIV:
              ra = Bitpack_getu(cur_instruction, 3, 6);
              rb = Bitpack_getu(cur_instruction, 3, 3);
              rc = Bitpack_getu(cur_instruction, 3, 0);
              op_division(ra, rb, rc);
              break;
          case NAND:
              ra = Bitpack_getu(cur_instruction, 3, 6);
              rb = Bitpack_getu(cur_instruction, 3, 3);
              rc = Bitpack_getu(cur_instruction, 3, 0);
              op_bitwise_NAND(ra, rb, rc);
              break;
          case HALT:
              doLoop = false;
              break;
          case ACTIVATE:
              rb = Bitpack_getu(cur_instruction, 3, 3);
              rc = Bitpack_getu(cur_instruction, 3, 0);
              op_map_segment(rb, rc);
              break;
          case INACTIVATE:
              rc = Bitpack_getu(cur_instruction, 3, 0);
              op_unmap_segment(rc);
              break;
          case OUT:
              rc = Bitpack_getu(cur_instruction, 3, 0);
              op_output(rc);
              break;
          case IN:
              rc = Bitpack_getu(cur_instruction, 3, 0);
              op_input(rc);
              break;
          case LOADP:
              rb = Bitpack_getu(cur_instruction, 3, 3);
              rc = Bitpack_getu(cur_instruction, 3, 0);
              op_load_program(rb, rc);
              instruction_segment = (Segment) Seq_get(um.mapped, 0);
              instructions = instruction_segment->words;
              continue;
          case LV:
              ra = Bitpack_getu(cur_instruction, 3, 25);
              uint32_t value = Bitpack_getu(cur_instruction, 25, 0);
              op_load_value(ra, value);
              break;
        }
        um.counter++;
    }
}

void free_um () {

    // Delete segments
    size_t num_segments = Seq_length(um.mapped);
    for (size_t i = 0; i < num_segments; i++) {

        // Free the all of the words in each segment
        Segment segment = Seq_get(um.mapped, i);
        int num_words = segment->length;
        if (num_words >= 1) {
            free(segment->words);
        }

        // Free the segment struct itself
        free(segment);
    }

    // Free struct fields
    Seq_free(&(um.mapped));
    Seq_free(&(um.unmapped));
}
