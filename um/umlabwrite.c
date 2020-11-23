#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "assert.h"
#include "fmt.h"
#include "seq.h"

extern void Um_write_sequence(FILE *output, Seq_T instructions);

extern void build_verbose_halt_test(Seq_T instructions);

extern void build_halt_test(Seq_T instructions);
extern void build_load_value_output_test(Seq_T instructions);
extern void build_input_test(Seq_T stream);
extern void build_move_test(Seq_T stream);
extern void build_addition_test(Seq_T instructions);
extern void build_multiplication_test(Seq_T stream);
extern void build_division_test(Seq_T stream);
extern void build_nand_test(Seq_T stream);
extern void build_map_segment_test_1(Seq_T stream);
extern void build_unmap_segment_test_1(Seq_T stream);
extern void build_segment_store_load_test_1(Seq_T stream);
extern void build_load_program_test_1(Seq_T stream);
extern void map_0_segments(Seq_T stream);
extern void map_and_umap_0_segments(Seq_T stream);
extern void halt_from_load_program(Seq_T stream);
extern void check_initial_register_values(Seq_T stream);
extern void segment_words_initial_values(Seq_T stream);
extern void segment_ids_reused(Seq_T stream);

/* The array `tests` contains all unit tests for the lab. */

static struct test_info {
        const char *name;
        const char *test_input;          /* NULL means no input needed */
        const char *expected_output;
        /* writes instructions into sequence */
        void (*build_test)(Seq_T stream);
} tests[] = {
        // Given tests
        { "halt-verbose", NULL, "", build_verbose_halt_test },

        // Unit tests
        { "halt",         NULL, "", build_halt_test },
        { "output_and_loadval", NULL, "B", build_load_value_output_test},
        { "input", "PNM", "PNM", build_input_test },
        { "conditional_move", NULL, "PPM", build_move_test },
        { "addition", NULL, "6", build_addition_test },
        { "multiplication", NULL, "2", build_multiplication_test },
        { "division", NULL, "3", build_division_test },
        { "bitwise_NAND", NULL, "2", build_nand_test },
        { "map_segment", NULL, "", build_map_segment_test_1 },
        { "unmap_segment", NULL, "", build_unmap_segment_test_1 },
        { "load_store_segment", NULL, "OS", build_segment_store_load_test_1 },
        { "load_program", NULL, "", build_load_program_test_1 },

        // Stress Tests
        { "map_0_segments", NULL, "F", map_0_segments },
        { "map_and_umap_0_segments", NULL, "F", map_and_umap_0_segments },
        { "halt_instruction_from_load_program", NULL, "F", halt_from_load_program},
        // { "segment_ids_reused", NULL, "0", segment_ids_reused}
        // { "segment_words_initial_values", NULL, "", segment_words_initial_values}
        // { "initial_register_value_check", NULL, "0", check_initial_register_values}
};


#define NTESTS (sizeof(tests)/sizeof(tests[0]))

/*
 * open file 'path' for writing, then free the pathname;
 * if anything fails, checked runtime error
 */
static FILE *open_and_free_pathname(char *path);


/*
 * if contents is NULL or empty, remove the given 'path',
 * otherwise write 'contents' into 'path'.  Either way, free 'path'.
 */
static void write_or_remove_file(char *path, const char *contents);

static void write_test_files(struct test_info *test);


int main (int argc, char *argv[])
{
        bool failed = false;
        if (argc == 1)
                for (unsigned i = 0; i < NTESTS; i++) {
                        printf("***** Writing test '%s'.\n", tests[i].name);
                        write_test_files(&tests[i]);
                }
        else
                for (int j = 1; j < argc; j++) {
                        bool tested = false;
                        for (unsigned i = 0; i < NTESTS; i++)
                                if (!strcmp(tests[i].name, argv[j])) {
                                        tested = true;
                                        write_test_files(&tests[i]);
                                }
                        if (!tested) {
                                failed = true;
                                fprintf(stderr,
                                        "***** No test named %s *****\n",
                                        argv[j]);
                        }
                }
        return failed; /* failed nonzero == exit nonzero == failure */
}


static void write_test_files(struct test_info *test)
{
        FILE *binary = open_and_free_pathname(Fmt_string("%s.um", test->name));
        Seq_T instructions = Seq_new(0);
        test->build_test(instructions);
        Um_write_sequence(binary, instructions);
        Seq_free(&instructions);
        fclose(binary);

        write_or_remove_file(Fmt_string("%s.0", test->name),
                             test->test_input);
        write_or_remove_file(Fmt_string("%s.1", test->name),
                             test->expected_output);
}


static void write_or_remove_file(char *path, const char *contents)
{
        if (contents == NULL || *contents == '\0') {
                remove(path);
        } else {
                FILE *input = fopen(path, "wb");
                assert(input != NULL);

                fputs(contents, input);
                fclose(input);
        }
        free(path);
}


static FILE *open_and_free_pathname(char *path)
{
        FILE *fp = fopen(path, "wb");
        assert(fp != NULL);

        free(path);
        return fp;
}