#include <iostream>
#include <string>
// #include "displayArray.cpp"

extern "C" double manager();
// extern "C" void displayArray(double my[], long max);

int main(){
    std::cout<< "Welcome to Arrays of Integers\nBrought to you by Jia Wei Ng\n\n";
    double returnValue = manager();

    std::cout << "Main received " << returnValue << ", and will keep it for future use. \n"
            << "Main will now return 0 to the operating system. Bye";

    return 0;
}
