CC=gcc
CFLAGS=-g


all: main1 main2

main1: main.o inc.o
	$(CC) $^ -o $@

main2: main.o use.o
	$(CC) $^ -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f main1  main2 *.o
#gcc -g -c main.c -o main.o && gcc -g -c inc.c -o inc.o && gcc -g -c use.c -o use.o && gcc main.o inc.o -o main1 && gcc main.o use.o -o main2
