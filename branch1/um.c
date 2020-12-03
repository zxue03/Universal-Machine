#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <seq.h>
#include <assert.h>
#include <except.h>
#include <inttypes.h>

#define UM_WORD_WIDTH 32
#define MAX_VAL 4294967296
#define NUM_REGISTERS 8
#define SEGMENT_HINT 65536

typedef struct Segment {
    uint32_t length;
    uint32_t *words;
} Segment;

const uint32_t SEGMENT_SIZE = sizeof(Segment);
const uint32_t UINT32_T_SIZE = sizeof(uint32_t);

typedef struct Seg_Dynamic_Array {
    uint32_t num_elements;
    uint32_t num_actual;
    Segment *seg_array;
} Seg_Dynamic_Array;

Seg_Dynamic_Array segments;

static inline void Seg_Dynamic_Array_init() {
    segments.num_elements = 0;
    segments.num_actual = SEGMENT_HINT;
    segments.seg_array = malloc(SEGMENT_HINT * SEGMENT_SIZE);
}

static inline void Seg_Dynamic_Array_ensure_size() {
    if (segments.num_elements < segments.num_actual) {
        return;
    }

    Segment *new_seg_array = malloc(segments.num_actual * 2 * SEGMENT_SIZE);

    segments.num_actual *= 2;

    for (uint32_t i = 0; i < segments.num_elements; i++) {
        new_seg_array[i] = segments.seg_array[i];
    }

    free(segments.seg_array);

    segments.seg_array = new_seg_array;
}

static inline void Seg_Dynamic_Array_remove() {
    segments.num_elements--;
}

typedef uint32_t Um_instruction;

typedef enum Um_opcode {
        CMOV = 0, SLOAD, SSTORE, ADD, MUL, DIV,
        NAND, HALT, ACTIVATE, INACTIVATE, OUT, IN, LOADP, LV
} Um_opcode;

typedef enum Um_register {
    r0 = 0, r1, r2, r3, r4, r5, r6, r7
} Um_register;

typedef struct UM {
    uint32_t registers [NUM_REGISTERS];
    uint32_t counter;
    Seq_T unmapped;
} UM;

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
    um.registers[ra] = ((segments.seg_array[um.registers[rb]]).words)[um.registers[rc]];
}

static inline void op_segmented_store(Um_register ra, Um_register rb, Um_register rc)
{
    ((segments.seg_array[um.registers[ra]]).words)[um.registers[rb]] = um.registers[rc];

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
    uint32_t *real_memory = malloc(UINT32_T_SIZE * um.registers[rc]);
    assert(real_memory != NULL);
  
    for (uint32_t i = 0; i < um.registers[rc]; i++) {
        real_memory[i] = 0;
    }

    uint32_t id;

    if (Seq_length(um.unmapped) > 0){
        id = (uint32_t)(uintptr_t)Seq_remlo(um.unmapped);
    } else {

        Seg_Dynamic_Array_ensure_size();
        id = segments.num_elements;
        segments.num_elements++;
    }

    (segments.seg_array[id]).words = real_memory;
    (segments.seg_array[id]).length = um.registers[rc];

    um.registers[rb] = id;

}

static inline void op_unmap_segment(Um_register rc)
{
    free((segments.seg_array[um.registers[rc]]).words);
    (segments.seg_array[um.registers[rc]]).length = 0;
    (segments.seg_array[um.registers[rc]]).words = NULL;

    Seq_addhi(um.unmapped, (void *)(uintptr_t)um.registers[rc]);
}

static inline void op_output(Um_register rc)
{
    printf("%c", um.registers[rc]);
}

static inline void op_input(Um_register rc)
{
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
    um.counter = um.registers[rc];
    
    if (um.registers[rb] == 0) {
        return;
    }


    free((segments.seg_array[0]).words);

    Segment load_from = (segments.seg_array[um.registers[rb]]);

    uint32_t *new_words = malloc(load_from.length * UINT32_T_SIZE);
    assert(new_words != NULL);
    
    for (uint32_t i = 0; i < load_from.length; i++)  {
        new_words[i] = (load_from.words)[i];
    }

    (segments.seg_array[0]).length = load_from.length;
    (segments.seg_array[0]).words = new_words;
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

static inline uint64_t shr(uint64_t word, unsigned bits)
{
        assert(bits <= 64);
        if (bits == 64)
                return 0;
        else
                return word >> bits;
}

bool Bitpack_fitsu(uint64_t n, unsigned width)
{
        assert(width <= 64);
        return shr(n, width) == 0;
}

static inline uint64_t Bitpack_getu(uint64_t word, unsigned width, unsigned lsb)
{
        assert(width <= 64);
        unsigned hi = lsb + width;
        assert(hi <= 64);
        return shr(shl(word, 64 - hi),
                   64 - width);
}

uint64_t Bitpack_newu(uint64_t word, unsigned width, unsigned lsb,
                      uint64_t value)
{
        assert(width <= 64);
        unsigned hi = lsb + width;
        assert(hi <= 64);
        if (!Bitpack_fitsu(value, width))
                RAISE(Bitpack_Overflow);
        return shl(shr(word, hi), hi)
                | shr(shl(word, 64 - lsb), 64 - lsb)
                | (value << lsb);
}

void read_instructions (FILE *fp) {

    Seq_T instructions = Seq_new(10000);

    while (true) {
        int c = fgetc(fp);
        if (c == -1) {
            break;
        } else {
            ungetc(c, fp);
        }
        Um_instruction word = 0;
        for (int i = 24; i >= 0 ; i -= 8) {
            int byte = fgetc(fp);
            word = Bitpack_newu(word, 8, i, byte);
        }
        Seq_addhi(instructions, (void *)(uintptr_t)word);
    }

    (segments.seg_array[0]).length = Seq_length(instructions);
    uint32_t *words = malloc(UINT32_T_SIZE * Seq_length(instructions));
    assert(words != NULL);
    for (uint32_t i = 0; i < (segments.seg_array[0]).length; i++) {
        words[i] = (uint32_t)(uintptr_t)Seq_get(instructions, i);
    }

    (segments.seg_array[0]).words = words;

    segments.num_elements++;

    Seq_free(&instructions);
}

void execute_instructions () {

    Um_register ra = -1;
    Um_register rb = -1;
    Um_register rc = -1;

    uint32_t *instructions = (segments.seg_array[0]).words;
    Um_instruction cur_instruction = 0;
    int opcode = -1;
    bool doLoop = true;

    while (doLoop) {

        cur_instruction = instructions[um.counter];

        opcode = Bitpack_getu(cur_instruction, 4, 28);
        
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
              if(um.registers[rb] != 0){
                instructions = (segments.seg_array[0]).words;
              }
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
    size_t num_segments = (segments.num_elements);
    for (size_t i = 0; i < num_segments; i++) {
        if ( (segments.seg_array[i]).length >= 1){
            free((segments.seg_array[i]).words);
        }
    }
    Seq_free(&(um.unmapped));
    free(segments.seg_array);
}

void run_um (FILE *file) {

    Seg_Dynamic_Array_init();
    
    um.counter = 0;

    for(int i = 0; i < NUM_REGISTERS; i++){
        um.registers[i] = 0;
    }

    um.unmapped = Seq_new(SEGMENT_HINT);
    assert(um.unmapped != NULL);

    read_instructions(file);

    execute_instructions();

    free_um();
}

int main(int argc, char **argv)
{
    if (argc != 2) {
        exit(EXIT_FAILURE);
    }
    FILE *fp = fopen(argv[1], "r");
    if (fp == NULL) {
        exit(EXIT_FAILURE);
    }
    
    run_um(fp);

    fclose(fp);
}