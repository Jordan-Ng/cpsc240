echo "--removing previously assembled files--"
rm *.o *.out

echo "--assembling assembly file--"
nasm -felf64 pythagoras.asm -o pythagoras.o

echo "--compiling c++ files--"
g++ -c -m64 -Wall -no-pie -fno-pie -std=c++20 driver.cpp -o driver.o

echo "--linking object files to make executable--"
g++ -m64 -Wall -no-pie -fno-pie -std=c++20 pythagoras.o driver.o -o driver.out
