# PoC for kas_alias Issue with compat_binfmt_elf.c

## Introduction

This PoC addresses an issue encountered with the `kas_alias` solution, which deals with duplicated symbols in the Linux kernel.
Specifically, the problem arises when working with the infamous `compat_binfmt_elf.c` file, which includes another C file (`binfmt_elf.c`), resulting in conflicting symbols.

The proposed solution employs the `#line` directive to modify the debug information included in the object file, effectively resolving the issue caused by the inclusion of `compat_binfmt_elf.c`.

## Overview
### kas_alias
`kas_alias` is a solution designed to handle duplicated symbols in the Linux kernel.
During the kernel build process, it inserts and utilizes `addr2line` to create aliases for duplicated symbols.
After processing, a duplicate symbol is assigned an alias consisting of the original symbol name concatenated with the full path filename and line number where it is defined.

### Compatibility Issue with compat_binfmt.c
The problem arises when dealing with `compat_binfmt_elf.c`, which includes another C file (`binfmt_elf.c`).
Due to this inclusion, symbols defined in `compat_binfmt_elf.c` are perceived by `addr2line` as if they are defined in `binfmt_elf.c`, resulting in conflicting symbols with identical names, including their paths and line numbers.

## Files in the PoC
|File|Function|Kernel equivalent|
|-----|--------|------|
inc.c|file c included in the other c|binfmt_elf.c|
incr.h|helper needed to implement preprocessor inc|NA|
main.c|main|NA|
main.h|header|NA|
use.c|file that includes another c file|compat_binfmt_elf.c|
test.sh|build the executables and demonstrates the poc|NA|

## Sample Run
```
~ $ ./test.sh 
rm -f main1  main2 *.o
gcc -g -c main.c -o main.o
gcc -g -c inc.c -o inc.o
gcc main.o inc.o -o main1
gcc -g -c use.c -o use.o
gcc main.o use.o -o main2
testing line where print_test is defined in main1:
print_test
/tmp/test_line/inc.c:10
testing line where print_test is defined in main2:
print_test
/tmp/test_line/inc.c:use.c:10
```
