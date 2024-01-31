#include <stdio.h>
#include "incr.h"

#ifndef FMT
#define FMT_STR "TEST_STR1 %d\n"
#else
#line INC_LINE(__LINE__) "inc.c:use.c"
#endif

void print_test(int a){
	printf(FMT_STR, a);
}
