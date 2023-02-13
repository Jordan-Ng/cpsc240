clear

echo "--removing previously assembled files--"
rm *.o *.out

echo "--assembling assembly file--"
nasm -felf64 manager.asm -o manager.o
nasm -felf64 input_array.asm -o input_array.o
# nasm -felf64 display_array.asm -o display_array.o

echo "--compiling c++ files--"
g++ -c -m64 -Wall -no-pie -fno-pie -std=c++2a main.cpp -o main.o
g++ -c -m64 -Wall -no-pie -fno-pie -std=c++2a displayArray.cpp -o displayArray.o

echo "--linking object files to make executable--"
g++ -m64 -Wall -no-pie -fno-pie -std=c++2a manager.o input_array.o displayArray.o main.o -o main.out

echo -e "-- running executable file -- \n"
./main.out

echo -e "\n-- printing exit status of program --"
echo $?

echo "-- cleaning up --"
rm *.o *.out