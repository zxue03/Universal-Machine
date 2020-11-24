# README
## Authors
Kevin Gao (kgao03) and Zhicheng Xue (zxue03)

## Acknowledgements
* We'd like to thank the TAs for helping us with handling the 64-bit memory
pointers and shell scripting.
* We'd like to thank the COMP-40 staff for providing the bitpack interface
and the um-lab files, which greatly eased the unit testing process.

## Implementation
* To the best of our knowledge, we believe we have implemented everything
correctly.
* We have implemented the um based on our design for the most part. The only
part we have changed is we don't have a separate file to generating unit tests
for um operations, simply because we realize the provided um-lab program is
perfect for unit testing.

## Architecture and Modules
The only interface that's exposed to the clients is um_engine.h, all the
structure definitions are hidden.
* um_util.h: 
This file standardizes inter-module communication by specifying
the structure of shared structs, enums, and constants. In particular, it
defines the UM struct, which contains the registers and memory Sequences.

* um_operations.h: 
Function declarations of um_operations, which handle the
execution of each operation instruction.

* um_operations.c: 
Implementation of the functions of um_operations, which
handle the execution of each operation instruction.

* um_engine.h: 
Public interface of um_engine, namely run_um, which handles
starting a um machine, executing the instructions, and freeing relevant memory.

* um_engine.c: 
Implements the functions of um_engine, which handles starting
a um machine, executing the instructions, and freeing all relevant memory

* um.c: 
Driver of the emulator - opens up the .um file and uses um_engine
interface to run the um.

## Performance of 50 million instructions
Approximately 2.67s.

Here is what we ran:

time ./um midmark.um

midmark.um is about 80 million and we got a wall time of 4.25s.

Based on that, running 50 million instructions should take roughly 2.67s.

## Unit Tests and Special Tests
Our unit tests were built incrementally, such that the testing of each
individual operation only assumes that previously unit-tested operations
are functional. We ran them in this order and not necessarily in the order
they are listed below.

Special tests were specifically designed to test DEFINED edge cases of the um,
and are labeled accordingly in the description.
* halt.um

Unit Test for halt - ensures a single halt instruction stops the program.
* output_and_loadval.um

Unit Test for output and loadval - we test multiple operations as suggested by
a TA because we need to load a value before we can actual ensure output works
correctly.
* input.um

Unit Test for input - loads a value using input into a register and
immediately prints it out to ensure that the value was read in correctly.
* conditional_move.um

Unit Test for conditional_move - tests both cases where conditional_move
should and should not copy the contents of a register.
* addition.um

Unit Test for addition - after loading two values, ensure the output after
doing addition is correct.
* multiplication.um

Unit Test for multiplication - after loading two values, ensure the output
after doing multiplication is correct.
* division.um

Unit Test for division - after loading two values, ensure the output
after doing division is correct.
* bitwise_NAND.um

Unit Test for bitwise_NAND - after loading two values, ensure the output
after doing a bitwise NAND is correct.
* map_segment.um

Unit Test for map_segment - ensures a segment can be correctly allocated
without errors - maps a segment.
* unmap_segment.um

Unit Test for unmap_segment - ensures a segment can be correctly freed
without errors - maps and then unmaps a segment.
* load_store_segment.um

Unit Test for segment_load and segment_store - ensures a value can be correctly
stored and loaded from a mapped segment without errors. Stores a value into
a mapped segment, loads it back, and outputs it to ensure it is correct.
* load_program.um

Unit Test for load_program - ensures that new programs are correctly loaded and
run - calculates a halt instruction at runtime and loads it as a program.
* map_0_segments.um

Special Test for map_segment - ensures a segment with 0 words can be correctly
mapped.
* map_and_umap_0_segments.um

Special Test for map_segment and unmap_segment - ensures a segment with 0 words
can be correctly mapped and unmapped.
* halt_instruction_from_load_program.um

Special Test for load_program - ensures a program with no halt instruction
initially can load a halt instruction calculated at runtime and exit
successfully
* initial_register_value_check.um

Special Test for architecture - ensures the initial values of the registers are
correct by adding 48 and ensure each output is 0.
* edit_instruction_segment.um

Special Test for store_segment - ensures that store_segment can be used
directly on m[0] by appending multiple output instructions, and storing a
halt instruction during runtime right before the final output - the .1 file
ensures that the final output function does not run.

## Hours Spent
* Analyzing

We spent around 3 hours understanding the problem and planning our solution

* Preparing design

We spent around 4 hours on designing.

* Solving

We spent around 14-18 hours implementing our solution

### Total: ~21-25 hours
