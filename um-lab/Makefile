#
# Makefile for the UM Test lab
#
CC = gcc

IFLAGS  = -I/comp/40/build/include -I/usr/sup/cii40/include/cii
CFLAGS  = -g -std=gnu99 -Wall -Wextra -Werror -pedantic $(IFLAGS)
LDFLAGS = -g -L/comp/40/build/lib -L/usr/sup/cii40/lib64
LDLIBS  = -l40locality -lcii40 -lm -lbitpack

EXECS   = writetests

INCLUDES = $(shell echo *.h)

%.o: %.c $(INCLUDES)
	$(CC) $(CFLAGS) -c $< -o $@

all: $(EXECS)

writetests: umlabwrite.o umlab.o instructions.o
	$(CC) $(LDFLAGS) $^ -o $@ $(LDLIBS)


clean:
	rm -f $(EXECS)  *.o
