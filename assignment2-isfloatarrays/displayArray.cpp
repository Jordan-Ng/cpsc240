#include <iostream>

extern "C" void displayArray(double myarray[], int max) {
    for (int i =0; i < max; i++){
        std::cout << myarray[i] << ", ";
    }
}