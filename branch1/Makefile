# Makefile for UM (Comp 40 Assignment 6)
# Authors: COMP-40 Staff
# Edited by: Louis Xue and Kevin Gao on 2020-11-18
#
# Includes build rules for UM

############## Variables ###############

CC = gcc -O2
IFLAGS = -I/comp/40/build/include -I/usr/sup/cii40/include/cii
CFLAGS = -g -std=gnu99 -Wall -Wextra -Werror -Wfatal-errors -pedantic $(IFLAGS)
LDFLAGS = -g -L/comp/40/build/lib -L/usr/sup/cii40/lib64
LDLIBS = -lcii40-O2 -lm -lrt -l40locality -larith40
INCLUDES = $(shell echo *.h)

############### Rules ###############

all: clean um

## Compile step (.c files -> .o files)

# To get *any* .o file, compile its .c file with the following rule.
%.o: %.c $(INCLUDES)
	$(CC) $(CFLAGS) -c $< -o $@

## Linking step (.o -> executable program)

um: um.o
	$(CC) $(LDFLAGS) $^ -o $@ $(LDLIBS)

clean:
	rm -f um op *.o *.1 *.0
