/*
*   um_util.h
*   Authors: Louis Xue (zxue03) and Kevin Gao (kgao03)
*
*   This class standardizes inter-module communication by specifying the
*   structure of shared structs, enums, and constants
*/
#ifndef UM_UTIL_INCLUDED
#define UM_UTIL_INCLUDED

#define UM_WORD_WIDTH 32
#define MAX_VAL 4294967296
#define NUM_REGISTERS 8

/*
* Um_opcode enum that standardizes the instruction operation codes
*/
typedef enum Um_opcode {
        CMOV = 0, SLOAD, SSTORE, ADD, MUL, DIV,
        NAND, HALT, ACTIVATE, INACTIVATE, OUT, IN, LOADP, LV
} Um_opcode;

/*
* Um_register enum that standardizes the register names
*/
typedef enum Um_register {
    r0 = 0, r1, r2, r3, r4, r5, r6, r7
} Um_register;

/*
* UM struct that represents the registers and segments of the simulated UM
*/
typedef struct UM {
    uint32_t registers [NUM_REGISTERS];
    uint32_t counter;
    Seq_T mapped;
    Seq_T unmapped;
} *UM;

/*
* Segment struct that represents a mapped segment
*/
typedef struct Segment {
    uint32_t length;
    uint32_t *words;
} *Segment;

// TODO: delete_segment

#endif