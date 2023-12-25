#!/bin/bash

gcc main.c -o main.exe

printf "\n"

printf "no n line, no fflush, no file\n"

./main.exe remove_fflush

printf "\n\n"

printf "add n line, no fflush, no file\n"

./main.exe add_n remove_fflush

printf "\n"

printf "no n line, add fflush, no file\n"

./main.exe

printf "\n\n"

printf "add n line, add fflush, no file\n"

./main.exe add_n

printf "\n"

printf "no n line, no fflush, add file 'test1.txt' \n"

./main.exe remove_fflush -o test1.txt

printf "\n"

printf "add n line, add fflush, add file 'test2.txt' \n"

./main.exe add_n -o test2.txt