/*
*   um_engine.h
*   Authors: Louis Xue (zxue03) and Kevin Gao (kgao03)
*
*   This class declares the functions of um_engine, which handles starting
*   a um machine, executing the instructions, and freeing all relevant memory
*/

#ifndef UM_ENGINE_INCLUDED
#define UM_ENGINE_INCLUDED

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <seq.h>
#include <assert.h>
#include <except.h>

void run_um (FILE *file);

#endif
