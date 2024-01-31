#!/bin/sh
test_addr() {
	echo "testing line where print_test is defined in ${1}:"
	addr2line -fe ${1} $(objdump -d ${1} | grep "<print_test>:" | cut -d" " -f1)
}
make clean && make
test_addr main1
test_addr main2
