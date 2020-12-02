/*
*   um_engine.c
*   Authors: Louis Xue (zxue03) and Kevin Gao (kgao03)
*
*   This class implements the functions of um_engine, which handles starting
*   a um machine, executing the instructions, and freeing all relevant memory
*/


#include "um_engine.h"
#include "um_operations.h"
#include "um_util.h"


/*
 * What makes things hellish is that C does not define the effects of
 * a 64-bit shift on a 64-bit value, and the Intel hardware computes
 * shifts mod 64, so that a 64-bit shift has the same effect as a
 * 0-bit shift.  The obvious workaround is to define new shift functions
 * that can shift by 64 bits.
 */

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

/*
 * shift R arith
 */
static inline int64_t sra(uint64_t word, unsigned bits)
{
        assert(bits <= 64);
        if (bits == 64)
                bits = 63; /* will get all copies of sign bit,
                            * which is correct for 64
                            */
	/* Warning: following uses non-portable >> on
	   signed value...see K&R 2nd edition page 206. */
        return ((int64_t) word) >> bits;
}

/****************************************************************/
bool Bitpack_fitss( int64_t n, unsigned width)
{
        assert(width <= 64);
        int64_t narrow = sra(shl(n, 64 - width),
                             64 - width);
        return narrow == n;
}

bool Bitpack_fitsu(uint64_t n, unsigned width)
{
        assert(width <= 64);
        /* thanks to Jai Karve and John Bryan  */
        /* clever shortcut instead of 2 shifts */
        return shr(n, width) == 0;
}

/****************************************************************/

int64_t Bitpack_gets(uint64_t word, unsigned width, unsigned lsb)
{
        assert(width <= 64);
        if (width == 0) return 0;    /* avoid capturing unknown sign bit    */

        unsigned hi = lsb + width; /* one beyond the most significant bit */
        assert(hi <= 64);
        return sra(shl(word, 64 - hi),
                   64 - width);
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
uint64_t Bitpack_newu(uint64_t word, unsigned width, unsigned lsb,
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

uint64_t Bitpack_news(uint64_t word, unsigned width, unsigned lsb,
                      int64_t value)
{
        assert(width <= 64);
        if (!Bitpack_fitss(value, width))
                RAISE(Bitpack_Overflow);
        /* thanks to Michael Sackman and Gilad Gray */
        return Bitpack_newu(word, width, lsb, Bitpack_getu(value, width, 0));
}


















/*
* Constant declarations
*/
#define SEGMENT_HINT 65536

/*
* Function declarations
*/
UM initialize_um ();
void free_um (UM um_instance);
void read_instructions (UM um, FILE *fp);
void execute_instructions (UM um);

/*
* run_um
* Driver function of the UM, creates a new UM emulator with the given
* um instruction file, then executes the given instructions
* Arguemnts:
*   - file - file containing the initial UM instructions
* Return: void
*/
void run_um (FILE *file) {

    // Initialize a UM emulator
    UM um_instance = initialize_um();

    // Read in the initial instructions
    read_instructions(um_instance, file);

    // Loop through execution
    execute_instructions(um_instance);

    // Free the UM emulator
    free_um(um_instance);
}

/*
* intialize_um
* Private helper function that initializes a UM struct with the correct
* initial values
* Arguments: None
* Return: the newly malloc'd UM struct
*/
UM initialize_um () {

    // Malloc the struct
    UM um_instance = malloc(sizeof(struct UM));
    assert(um_instance != NULL);

    // Instruction counter
    um_instance->counter = 0;

    // Array for registers
    for(int i = 0; i < NUM_REGISTERS; i++){
        um_instance->registers[i] = 0;
    }

    // Sequences for segments
    um_instance->mapped = Seq_new(SEGMENT_HINT);
    assert(um_instance->mapped != NULL);
    um_instance->unmapped = Seq_new(SEGMENT_HINT);
    assert(um_instance->unmapped != NULL);

    return um_instance;
}

/*
* read_instructions
* Reads in the initial instructions of the program
* Arguments:
*   - fp - file pointer containing the initial UM instructions
* Return: void
*/
void read_instructions (UM um, FILE *fp) {

    // Create sequence to hold the instructions
    Seq_T instructions = Seq_new(100);

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
    Seq_addhi(um->mapped, (void *) segment0);

    Seq_free(&instructions);
}

/*
* execute_instructions
* Executes the instructions stored in m[0] starting at the counter of the UM
* Arguments:
*   - um - the UM emulator to run
* Return: void
*/
void execute_instructions (UM um) {



    Um_register ra = -1;
    Um_register rb = -1;
    Um_register rc = -1;

    Segment instruction_segment = (Segment) Seq_get(um->mapped, 0);
    uint32_t *instructions = instruction_segment->words;
    Um_instruction cur_instruction = 0;
    int opcode = -1;
    // Loop through each instruction
    while (true) {

        // Retrieve the segment and instructions
        if(opcode == LOADP){
            instruction_segment = (Segment) Seq_get(um->mapped, 0);
            instructions = instruction_segment->words;
        }

        // Retrieve the current instruction
        cur_instruction = instructions[um->counter];

        // Retrieve the opcode
        opcode = Bitpack_getu(cur_instruction, 4, 28);

        // Execute the corresponding instruction
        if (opcode == CMOV) {
            ra = Bitpack_getu(cur_instruction, 3, 6);
            rb = Bitpack_getu(cur_instruction, 3, 3);
            rc = Bitpack_getu(cur_instruction, 3, 0);
            op_conditional_move(um, ra, rb, rc);
        } else if (opcode == SLOAD) {
            ra = Bitpack_getu(cur_instruction, 3, 6);
            rb = Bitpack_getu(cur_instruction, 3, 3);
            rc = Bitpack_getu(cur_instruction, 3, 0);
            op_segmented_load(um, ra, rb, rc);
        } else if (opcode == SSTORE) {
            ra = Bitpack_getu(cur_instruction, 3, 6);
            rb = Bitpack_getu(cur_instruction, 3, 3);
            rc = Bitpack_getu(cur_instruction, 3, 0);
            op_segmented_store(um, ra, rb, rc);
        } else if (opcode == ADD) {
            ra = Bitpack_getu(cur_instruction, 3, 6);
            rb = Bitpack_getu(cur_instruction, 3, 3);
            rc = Bitpack_getu(cur_instruction, 3, 0);
            op_addition(um, ra, rb, rc);
        } else if (opcode == MUL) {
            ra = Bitpack_getu(cur_instruction, 3, 6);
            rb = Bitpack_getu(cur_instruction, 3, 3);
            rc = Bitpack_getu(cur_instruction, 3, 0);
            op_multiplication(um, ra, rb, rc);
        } else if (opcode == DIV) {
            ra = Bitpack_getu(cur_instruction, 3, 6);
            rb = Bitpack_getu(cur_instruction, 3, 3);
            rc = Bitpack_getu(cur_instruction, 3, 0);
            op_division(um, ra, rb, rc);
        } else if (opcode == NAND) {
            ra = Bitpack_getu(cur_instruction, 3, 6);
            rb = Bitpack_getu(cur_instruction, 3, 3);
            rc = Bitpack_getu(cur_instruction, 3, 0);
            op_bitwise_NAND(um, ra, rb, rc);
        } else if (opcode == HALT) {
            break;
        } else if (opcode == ACTIVATE) {
            rb = Bitpack_getu(cur_instruction, 3, 3);
            rc = Bitpack_getu(cur_instruction, 3, 0);
            op_map_segment(um, rb, rc);
        } else if (opcode == INACTIVATE) {
            rc = Bitpack_getu(cur_instruction, 3, 0);
            op_unmap_segment(um, rc);
        } else if (opcode == OUT) {
            rc = Bitpack_getu(cur_instruction, 3, 0);
            op_output(um, rc);
        } else if (opcode == IN) {
            rc = Bitpack_getu(cur_instruction, 3, 0);
            op_input(um, rc);
        } else if (opcode == LOADP) {
            rb = Bitpack_getu(cur_instruction, 3, 3);
            rc = Bitpack_getu(cur_instruction, 3, 0);
            op_load_program(um, rb, rc);
            continue;
        } else if (opcode == LV) {
            ra = Bitpack_getu(cur_instruction, 3, 25);
            uint32_t value = Bitpack_getu(cur_instruction, 25, 0);
            op_load_value(um, ra, value);
        }
        um->counter++;
    }
}

/*
* free_um
* Private helper function that frees all dynamically allocated memory
* associated with the given UM struct
* Arguemnts:
*   - um_instance - the UM to free
* Return: void
*/
void free_um (UM um_instance) {

    // Delete segments
    size_t num_segments = Seq_length(um_instance->mapped);
    for (size_t i = 0; i < num_segments; i++) {

        // Free the all of the words in each segment
        Segment segment = Seq_get(um_instance->mapped, i);
        int num_words = segment->length;
        if (num_words >= 1) {
            free(segment->words);
        }

        // Free the segment struct itself
        free(segment);
    }

    // Free struct fields
    Seq_free(&(um_instance->mapped));
    Seq_free(&(um_instance->unmapped));

    // Delete UM struct
    free(um_instance);
}
