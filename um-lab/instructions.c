#include "instructions.h"

/* Wrapper functions for each of the instructions */

Um_instruction halt(void)
{
        return three_register(HALT, 0, 0, 0);
}


Um_instruction input(Um_register c)
{
    return three_register(IN, 0, 0, c);
}

Um_instruction output(Um_register c)
{
    return three_register(OUT, 0, 0, c);
}

Um_instruction segmented_load(Um_register a, Um_register b, Um_register c)
{
    return three_register(SLOAD, a, b, c);
}

Um_instruction segmented_store(Um_register a, Um_register b, Um_register c)
{
    return three_register(SSTORE, a, b, c);
}

Um_instruction addition(Um_register a, Um_register b, Um_register c)
{
    return three_register(ADD, a, b, c);
}

Um_instruction multiplication(Um_register a, Um_register b, Um_register c)
{
    return three_register(MUL, a, b, c);
}

Um_instruction division(Um_register a, Um_register b, Um_register c)
{
    return three_register(DIV, a, b, c);
}

Um_instruction conditional_move(Um_register a, Um_register b, Um_register c)
{
    return three_register(CMOV, a, b, c);
}

Um_instruction map_segment(Um_register b, Um_register c)
{
    return three_register(ACTIVATE, 0, b, c);
}

Um_instruction unmap_segment(Um_register c)
{
    return three_register(INACTIVATE, 0, 0, c);
}

Um_instruction bitwise_NAND(Um_register a, Um_register b, Um_register c)
{
    return three_register(NAND, a, b, c);
}

Um_instruction load_program(Um_register b, Um_register c)
{
    return three_register(LOADP, 0, b, c);
}


Um_instruction three_register(Um_opcode op, Um_register a, Um_register b, Um_register c)
{
  Um_instruction word = 0;
  word = Bitpack_newu(word, 3, 0, a);
  word = Bitpack_newu(word, 3, 3, b);
  word = Bitpack_newu(word, 3, 6, c);
  word = Bitpack_newu(word, 4, 28, op);
  return word;
}

Um_instruction loadval(Um_register a, unsigned val) {
  Um_instruction word = 0;
  word = Bitpack_newu(word, 25, 0, val);
  word = Bitpack_newu(word, 25, 3, a);
  word = Bitpack_newu(word, 28, 4, LV);
  return word;
}
