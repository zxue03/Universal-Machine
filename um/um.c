/*
*   um.c
*   Authors: Louis Xue (zxue03) and Kevin Gao (kgao03)
*
*   This file holds the driver function for the program, opening the um
*   instruction file and starting an emulator
*/

#include "um_engine.h"
#include <assert.h>

int main(int argc, char **argv)
{
    // Open the file
    if (argc != 2) {
        fprintf(stderr, "Usage: ./um [um instruction file]");
        exit(EXIT_FAILURE);
    }
    FILE *fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "Specified um instruction file does not exist.");
        exit(EXIT_FAILURE);
    }

    // Create and run a UM emulator
    run_um(fp);
}