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

    // Loop through each instruction
    while (true) {

        // Retrieve the segment and instructions
        Segment instruction_segment = (Segment) Seq_get(um->mapped, 0);
        uint32_t *instructions = instruction_segment->words;

        // Retrieve the current instruction
        uint32_t cur_instruction = instructions[um->counter];

        // Retrieve the opcode
        int opcode = Bitpack_getu(cur_instruction, 4, 28);

        // Retrieve the corresponding registers used
        Um_register registers[8] = {r0, r1, r2, r3, r4, r5, r6, r7};
        Um_register ra;
        Um_register rb;
        Um_register rc;

        // Regular three_register instructions
        if (opcode != LV) {
            int ra_bits = Bitpack_getu(cur_instruction, 3, 6);
            int rb_bits = Bitpack_getu(cur_instruction, 3, 3);
            int rc_bits = Bitpack_getu(cur_instruction, 3, 0);

            // Match the bits of the word to their respective registers
            if (0 <= ra_bits && ra_bits <= 7) {
                ra = registers[ra_bits];
            }
            if (0 <= rb_bits && rb_bits <= 7) {
                rb = registers[rb_bits];
            }
            if (0 <= rc_bits && rc_bits <= 7) {
                rc = registers[rc_bits];
            }
            // Different location for ra in the load value operation
        } else {
            int ra_bits = Bitpack_getu(cur_instruction, 3, 25);
            if (0 <= ra_bits && ra_bits <= 7) {
                ra = registers[ra_bits];
            }
        }

        // Execute the corresponding instruction
        if (opcode == CMOV) {
            op_conditional_move(um, ra, rb, rc);
        } else if (opcode == SLOAD) {
            op_segmented_load(um, ra, rb, rc);
        } else if (opcode == SSTORE) {
            op_segmented_store(um, ra, rb, rc);
        } else if (opcode == ADD) {
            op_addition(um, ra, rb, rc);
        } else if (opcode == MUL) {
            op_multiplication(um, ra, rb, rc);
        } else if (opcode == DIV) {
            op_division(um, ra, rb, rc);
        } else if (opcode == NAND) {
            op_bitwise_NAND(um, ra, rb, rc);
        } else if (opcode == HALT) {
            if (op_halt() == 0) {
                break;
            }
        } else if (opcode == ACTIVATE) {
            op_map_segment(um, rb, rc);
        } else if (opcode == INACTIVATE) {
            op_unmap_segment(um, rc);
        } else if (opcode == OUT) {
            op_output(um, rc);
        } else if (opcode == IN) {
            op_input(um, rc);
        } else if (opcode == LOADP) {
            op_load_program(um, rb, rc);
            continue;
        } else if (opcode == LV) {
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