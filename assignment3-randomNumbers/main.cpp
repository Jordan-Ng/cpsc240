#include <iostream>
#include <string>

extern "C" char * executive();

int main(){
    std::cout << "Welcome to Random Products, LLC. \nThis software is maintained by Jia Wei Ng" <<std::endl;

    char * fullName = executive();
    std::cout << "Oh, "<< fullName << ". We hope you enjoyed your arrays. Do come again.\nA zero will be returned to the operating system." << std::endl;

    return 0;
}