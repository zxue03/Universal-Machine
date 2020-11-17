#include <stdint.h>
#include <stdio.h>
#include <assert.h>
#include <seq.h>
#include <bitpack.h>


typedef uint32_t Um_instruction;
typedef enum Um_opcode {
        CMOV = 0, SLOAD, SSTORE, ADD, MUL, DIV,
        NAND, HALT, ACTIVATE, INACTIVATE, OUT, IN, LOADP, LV
} Um_opcode;
typedef enum Um_register { r0 = 0, r1, r2, r3, r4, r5, r6, r7 } Um_register;


/* Functions that return the two instruction types */

Um_instruction three_register(Um_opcode op, Um_register a, Um_register b, Um_register c);
Um_instruction loadval(unsigned a, unsigned val);
Um_instruction halt(void);
Um_instruction input(Um_register c);
Um_instruction output(Um_register c);
Um_instruction segmented_load(Um_register a, Um_register b, Um_register c);
Um_instruction segmented_store(Um_register a, Um_register b, Um_register c);
Um_instruction load_program(Um_register b, Um_register c);
Um_instruction addition(Um_register a, Um_register b, Um_register c);
Um_instruction multiplication(Um_register a, Um_register b, Um_register c);
Um_instruction division(Um_register a, Um_register b, Um_register c);
Um_instruction conditional_move(Um_register a, Um_register b, Um_register c);
Um_instruction map_segment(Um_register b, Um_register c);
Um_instruction unmap_segment(Um_register c);
Um_instruction bitwise_NAND(Um_register a, Um_register b, Um_register c);
