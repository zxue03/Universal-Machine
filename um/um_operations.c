/*
*   um_operations.c
*   Authors: Louis Xue (zxue03) and Kevin Gao (kgao03)
*
*   This class implements the functions of um_operations, which handle the
*   execution of each operation instruction
*/

#include "um_operations.h"

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
void op_conditional_move(UM um, Um_register ra, Um_register rb,
                                                            Um_register rc)
{
    if (um->registers[rc] != 0) {
        um->registers[ra] = um->registers[rb];
    }
}

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
void op_segmented_load(UM um, Um_register ra, Um_register rb, Um_register rc)
{
    // Retrieve the segment
    Segment segment = (Segment) Seq_get(um->mapped, um->registers[rb]);
    uint32_t *words = segment->words;

    // Load the specified value into ra
    um->registers[ra] = words[um->registers[rc]];
}

/*
* op_segmented_store
* Performs the segmented store operation
* Assigns m[ra][rb] to rc
* Arguments:
*   - um - the UM struct with all register and segment information
*   - ra - the Um_register to interpret as ra
*   - rb - the Um_register to interpret as rb
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_segmented_store(UM um, Um_register ra, Um_register rb, Um_register rc)
{
    // Retrieve the segment
    Segment segment = (Segment) Seq_get(um->mapped, um->registers[ra]);
    uint32_t *words = segment->words;

    // Store the specific value
    words[um->registers[rb]] = um->registers[rc];
}

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
void op_addition(UM um, Um_register ra, Um_register rb, Um_register rc)
{
    um->registers[ra] = (um->registers[rb] + um->registers[rc]) % MAX_VAL;
}

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
void op_multiplication(UM um, Um_register ra, Um_register rb, Um_register rc)
{
      um->registers[ra] = (um->registers[rb] * um->registers[rc]) % MAX_VAL;
}

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
void op_division(UM um, Um_register ra, Um_register rb, Um_register rc)
{
      um->registers[ra] = um->registers[rb] / um->registers[rc];
}

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
void op_bitwise_NAND(UM um, Um_register ra, Um_register rb, Um_register rc)
{
      um->registers[ra] = ~(um->registers[rb] & um->registers[rc]);
}

/*
* op_halt
* Performs the halt operation
* Stops the UM
* Arguments:
*   - um - the UM struct with all register and segment information
* Return: 0
*/
int op_halt()
{
    return 0;
}

/*
* op_map_segment
* Performs the map_segment operation
* Creates a new segment with the number of words equal to the value in rc
* puts the identifier in rb
* Arguments:
*   - um - the UM struct with all register and segment information
*   - rb - the Um_register to interpret as rb
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_map_segment(UM um, Um_register rb, Um_register rc)
{
    // Allocate the memory for the segment
    uint32_t *real_memory = malloc(sizeof(uint32_t) * um->registers[rc]);
    assert(real_memory != NULL);

    // Initialize each word to 0
    for (uint32_t i = 0; i < um->registers[rc]; i++) {
        real_memory[i] = 0;
    }

    Segment updated_segment;

    // Assign to the lowest free index in mapped
    uint32_t id;
    if (Seq_length(um->unmapped) > 0){
        id = (uint32_t)(uintptr_t)Seq_remlo(um->unmapped);
        updated_segment = (Segment) Seq_get(um->mapped, id);
    } else {
        updated_segment = malloc(sizeof(*updated_segment));
        assert(updated_segment != NULL);
        id = Seq_length(um->mapped);
        Seq_addhi(um->mapped, (void *) updated_segment);
    }
    updated_segment->length = um->registers[rc];
    updated_segment->words = real_memory;

    um->registers[rb] = id;
}

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
void op_unmap_segment(UM um, Um_register rc)
{
    // Free the segment memory
    Segment segment = (Segment) Seq_get(um->mapped, um->registers[rc]);
    free(segment->words);
    segment->length = 0;
    segment->words = NULL;

    // Add the id to unmapped
    Seq_addhi(um->unmapped, (void *)(uintptr_t)um->registers[rc]);
}

/*
* op_output
* Performs the output operation
* Writes the value in rc to to the I/O device
* Arguments:
*   - um - the UM struct with all register and segment information
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_output(UM um, Um_register rc)
{
    // Print as unsigned char
    printf("%c", um->registers[rc]);
}

/*
* op_input
* Performs the input operation
* Loads input from the I/O device into rc
* Arguments:
*   - um - the UM struct with all register and segment information
*   - rc - the Um_register to interpret as rc
* Return: void
*/
void op_input(UM um, Um_register rc)
{
    // Take input from stdin
    unsigned char input;
    scanf("%c", &input);
    um->registers[rc] = input;
}

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
void op_load_program(UM um, Um_register rb, Um_register rc)
{
    // Set the instructions counter
    um->counter = um->registers[rc];

    // Check the loaded program is not m[0]
    if (um->registers[rb] == 0) {
        return;
    }

    // Retrieve the instructions segment
    Segment instructions_segment = (Segment) Seq_get(um->mapped, 0);
    free(instructions_segment->words);

    // Retrieve the segment to duplicate
    Segment load_from = (Segment) Seq_get(um->mapped, um->registers[rb]);

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

/*
* op_load_value
* performs the load_value operation
* loads the value in ra
* Arguments:
*   - um - the UM struct with all register and segment information
*   - ra - the Um_register to interpret as ra
*   - value - the value you want to load
* Return: void
*/
void op_load_value(UM um, Um_register ra, uint32_t value)
{
    um->registers[ra] = value;
}