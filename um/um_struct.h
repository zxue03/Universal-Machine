/*
*   um_struct.h
*   Authors: Louis Xue (zxue03) and Kevin Gao (kgao03)
*
*   This class holds the UM struct that represents the registers and segments
*   of the simulated UM
*/
typedef struct UM {
    uint32_t registers[NUM_REGISTERS];
    uint32_t counter;
    Seq_T mapped;
    Seq_T unmapped;
} *UM;