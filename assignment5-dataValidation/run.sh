clear
rm *.o *.out

nasm -f elf64 manager.asm -o manager.o
g++ -c -m64 -no-pie -fno-pie -Wall -std=c++2a main.cpp -o main.o

g++ -m64 -no-pie -fno-pie -Wall -std=c++2a *.o -o main.out

./main.out

rm *.o *.out