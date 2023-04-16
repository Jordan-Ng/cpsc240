clear
rm *.o *.out

nasm -f elf64 manager.asm -o manager.o
nasm -f elf64 getRadicand.asm -o getRadicand.o

g++ -c -m64 -Wall -no-pie -fno-pie -std=c++2a main.cpp -o main.o
g++ -m64 -Wall -no-pie -fno-pie -std=c++2a *.o -o main.out

./main.out
rm *.o *.out