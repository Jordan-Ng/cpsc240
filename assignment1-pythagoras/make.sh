echo "--removing previously assembled files--"
rm *.o *.out

echo "--assembling assembly file--"
nasm -felf64 pythagoras.asm -o pythagoras.o

echo "--compiling c++ files--"
g++ -c -m64 -Wall -no-pie -fno-pie -std=c++2a driver.cpp -o driver.o

echo "--linking object files to make executable--"
g++ -m64 -Wall -no-pie -fno-pie -std=c++2a pythagoras.o driver.o -o driver.out

echo -e "-- running executable file -- \n"
./driver.out

echo -e "\n-- printing exit status of program --"
echo $?

echo "-- cleaning up --"
rm *.o *.out