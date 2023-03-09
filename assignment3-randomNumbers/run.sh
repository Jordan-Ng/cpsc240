clear
rm *.o *.out || echo

nasm -felf64 executive.asm -o executive.o
nasm -felf64 display_array.asm -o display_array.o
nasm -felf64 isNaN.asm -o isNaN.o
nasm -felf64 fill_random_array.asm -o fill_random_array.o

g++ -c -m64 -Wall -no-pie -fno-pie -std=c++2a main.cpp -o main.o
g++ -c -m64 -Wall -no-pie -fno-pie -std=c++2a quick_sort.cpp -o quick_sort.o

g++ -m64 -Wall -no-pie -fno-pie -std=c++2a *.o -o main.out
./main.out
rm *.o *.out || echo