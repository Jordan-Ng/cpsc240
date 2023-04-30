#include <iostream>
#include <string>

extern "C" long manager();

int main(){
    std::cout   << "Welcome to Asterix Software Development Corporation\n" 
                << "This program Sine function Benchmark is maintained by Jia Wei Ng" << std::endl;

    long elapsedTime = manager();

    std::cout   << "Thank you for using this program. Have a great day.\n"
                << "The driver program received this number " << elapsedTime << ". A zero will be returned to the OS. Bye." << std::endl;

    return 0;
}