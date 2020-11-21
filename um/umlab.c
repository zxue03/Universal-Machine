/*
* umlab.c
*
* Functions to generate UM unit tests. Once complete, this module
* should be augmented and then linked against umlabwrite.c to produce
* a unit test writing program.
*
* A unit test is a stream of UM instructions, represented as a Hanson
* Seq_T of 32-bit words adhering to the UM's instruction format.
*
* Any additional functions and unit tests written for the lab go
* here.
*
*/


#include <stdint.h>
#include <stdio.h>
#include <assert.h>
#include <seq.h>
#include <bitpack.h>
#include "instructions.h"

const uint32_t Um_word_width = 32;

/* Functions for working with streams */

static inline void append(Seq_T stream, Um_instruction inst)
{
    assert(sizeof(inst) <= sizeof(uintptr_t));
    Seq_addhi(stream, (void *)(uintptr_t)inst);
}

void Um_write_sequence(FILE *output, Seq_T stream)
{
    assert(output != NULL && stream != NULL);
    int stream_length = Seq_length(stream);
    for (int i = 0; i < stream_length; i++) {
        Um_instruction inst = (uintptr_t)Seq_remlo(stream);
        for (int lsb = Um_word_width - 8; lsb >= 0; lsb -= 8) {
            fputc(Bitpack_getu(inst, 8, lsb), output);
        }
    }

}


/* Unit tests for the UM */

void build_halt_test(Seq_T stream)
{
    append(stream, halt());
}

void build_verbose_halt_test(Seq_T stream)
{
    append(stream, halt());
    append(stream, loadval(r1, 'B'));
    append(stream, output(r1));
    append(stream, loadval(r1, 'a'));
    append(stream, output(r1));
    append(stream, loadval(r1, 'd'));
    append(stream, output(r1));
    append(stream, loadval(r1, '!'));
    append(stream, output(r1));
    append(stream, loadval(r1, '\n'));
    append(stream, output(r1));
}

void build_addition_test(Seq_T stream)
{
    // append(stream, loadval(r1, 'a'));
    append(stream, loadval(r1, 48));
    append(stream, loadval(r2, 6));
    append(stream, addition(r3, r1, r2));
    append(stream, output(r3));
    append(stream, halt());
}

void build_multiplication_test(Seq_T stream)
{
    append(stream, loadval(r1, 10));
    append(stream, loadval(r2, 5));
    append(stream, multiplication(r3, r1, r2));
    append(stream, output(r3));
    append(stream, halt());
}

void build_division_test(Seq_T stream)
{
    append(stream, loadval(r1, 102));
    append(stream, loadval(r2, 2));
    append(stream, division(r3, r1, r2));
    append(stream, output(r3));
    append(stream, halt());
}

void build_nand_test(Seq_T stream)
{
    append(stream, loadval(r1, 33554421));
    append(stream, loadval(r2, 33554428));
    append(stream, bitwise_NAND(r3, r1, r2));
    append(stream, loadval(r4, 22));
    append(stream, addition(r3, r3, r4));
    append(stream, output(r3));
    append(stream, halt());
}

void build_move_test(Seq_T stream)
{
    append(stream, loadval(r1, 77));
    append(stream, loadval(r2, 80));
    append(stream, loadval(r3, 0));
    append(stream, loadval(r4, 1));

    // Output r2: should be 80 = P
    append(stream, output(r2));

    // conditional move that fails: r2 should still be 80 = P
    append(stream, conditional_move(r2, r1, r3));
    append(stream, output(r2));

    // conditional move that succeeds: r2 should still be 77 = M
    append(stream, conditional_move(r2, r1, r4));
    append(stream, output(r2));
    append(stream, halt());
}

void build_input_test(Seq_T stream)
{
    append(stream, input(r1));
    append(stream, output(r1));
    append(stream, input(r2));
    append(stream, output(r2));
    append(stream, input(r3));
    append(stream, output(r3));
    append(stream, halt());
}

void build_no_halt_test(Seq_T stream)
{
    append(stream, loadval(r4, 22));
}

void build_map_segment_test_1(Seq_T stream)
{
    append(stream, loadval(r1, 77));
    append(stream, loadval(r3, 80));
    append(stream, output(r1));
    append(stream, output(r3));
    append(stream, map_segment(r2, r1));
    append(stream, map_segment(r4, r3));
    append(stream, output(r2));
    append(stream, output(r4));
    append(stream, halt());
}