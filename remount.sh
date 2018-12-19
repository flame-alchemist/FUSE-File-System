#!/bin/sh

fusermount -u tmp
gcc fs.c -c `pkg-config fuse --cflags --libs`
gcc structure_functions.c -c
gcc structure_functions.o fs.o `pkg-config fuse --cflags --libs` -o fs
./fs -f tmp/
