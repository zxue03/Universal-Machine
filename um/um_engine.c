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
UM intialize_um();
void free_um(UM um_instance);

/*
* intialize_um
* Private helper function that initializes a UM struct with the correct
* initial values
* Arguments: None
* Return: the newly malloc'd UM struct
*/
UM intialize_um() {

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


void run_um() {

}

/*
* free_um
* Private helper function that frees all dynamically allocated memory
* associated with the given UM struct
* Arguemnts:
*   - um_instance - the UM to free
* Return: void
*/
void free_um(UM um_instance) {

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