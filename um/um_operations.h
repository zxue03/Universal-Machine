/*
*   um_operations.h
*   Authors: Louis Xue (zxue03) and Kevin Gao (kgao03)
*
*   This class declares the functions of um_operations, which handle the
*   execution of each operation instruction
*/
#ifndef UM_OPERATIONS_INCLUDED
#define UM_OPERATIONS_INCLUDED

#include <stdio.h>
#include <stdlib.h>
#include <seq.h>
#include <assert.h>
#include <bitpack.h>

#include "um_util.h"

extern UM;

/*
* op_conditional_move
* Performs the conditional move operation
* Assigns ra to rb if rc is not 0
* Arguments:
*   - um - the UM struct with all register and segment information
*   - ra - the Um_register to interpret as ra
*   - rb - the Um_register to interpret as rb
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_conditional_move(UM um, Um_register ra, Um_resigter rb,
                                                            Um_register rc);

/*
* op_segmented_load
* Performs the segmented_load operation
* Loads the value at m[rb][rc] to ra
* Arguments:
*   - um - the UM struct with all register and segment information
*   - ra - the Um_register to interpret as ra
*   - rb - the Um_register to interpret as rb
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_segmented_load(UM um, Um_register ra, Um_resigter rb, Um_register rc);

/*
* op_segmented_store
* Performs the segmented store operation
* Assigns rc to m[ra][rb]
* Arguments:
*   - um - the UM struct with all register and segment information
*   - ra - the Um_register to interpret as ra
*   - rb - the Um_register to interpret as rb
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_segmented_store(UM um, Um_register ra, Um_resigter rb, Um_register rc);

/*
* op_addtion
* Performs the addtion operation
* Assigns ra to the sum of rb and rc
* Arguments:
*   - um - the UM struct with all register and segment information
*   - ra - the Um_register to interpret as ra
*   - rb - the Um_register to interpret as rb
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_addition(UM um, Um_register ra, Um_resigter rb, Um_register rc);

/*
* op_multiplication
* Performs the multiplication operation
* Assigns ra to the product of rb and rc
* Arguments:
*   - um - the UM struct with all register and segment information
*   - ra - the Um_register to interpret as ra
*   - rb - the Um_register to interpret as rb
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_multiplication(UM um, Um_register ra, Um_resigter rb, Um_register rc);

/*
* op_division
* Performs the division operation
* Assigns ra to the quotient of rb and rc
* Arguments:
*   - um - the UM struct with all register and segment information
*   - ra - the Um_register to interpret as ra
*   - rb - the Um_register to interpret as rb
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_division(UM um, Um_register ra, Um_resigter rb, Um_register rc);

/*
* op_bitwise_NAND
* Performs the NAND operation
* Assigns ra to the bitwise NAND of rb and rc
* Arguments:
*   - um - the UM struct with all register and segment information
*   - ra - the Um_register to interpret as ra
*   - rb - the Um_register to interpret as rb
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_bitwise_NAND(UM um, Um_register ra, Um_resigter rb, Um_register rc);

/*
* op_halt
* Performs the halt operation
* Stops the UM
* Arguments:
*   - um - the UM struct with all register and segment information
* Return: void
*/
void op_halt(UM um);

/*
* op_map_segment
* Performs the map_segment operation
* Creates a new segment with the number of words euqal to the value in rc
* puts the identifier in rb
* Arguments:
*   - um - the UM struct with all register and segment information
*   - rb - the Um_register to interpret as rb
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_map_segment(UM um, Um_register rb, Um_register rc);

/*
* op_unmap_segment
* Performs the unmap_segment operation
* Unmaps the segment m[rc] and the identifier in rc can be reused in the future
* Arguments:
*   - um - the UM struct with all register and segment information
*   - rb - the Um_register to interpret as rb
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_unmap_segment(UM um, Um_register rc);

/*
* op_output
* Performs the output operation
* Writes the value in rc to to the I/O device
* Arguments:
*   - um - the UM struct with all register and segment information
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_output(UM um, Um_register rc);

/*
* op_input
* Performs the input operation
* Loads input from the I/O device into rc
* Arguments:
*   - um - the UM struct with all register and segment information
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_input(UM um, Um_register rc);

/*
* op_load_program
* Performs the load program operation
* Duplicates the segment m[rb] and sets the program counter to m[0]rc
* Arguments:
*   - um - the UM struct with all register and segment information
*   - rb - the Um_register to interpret as rb
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_load_program(UM um, Um_register rb, Um_register rc);

/*
* op_load_value
*
* Arguments:
*   - um - the UM struct with all register and segment information
*   - ra - the Um_register to interpret as ra
* Return: void
*/
void op_load_value(UM um, Um_register ra, );

#endif