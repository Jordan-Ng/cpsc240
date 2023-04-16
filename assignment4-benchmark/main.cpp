#include <iostream>
#include <string>

extern "C" double manager();


int main(){
    // char * vendorInformation = manager();

    // std::cout << "Vendor: " << vendorInformation << std::endl;
    double result = manager();
    // std::cout << "Clock Speed: " << clockFrequency << std::endl;
    
    std::cout << "\n\nThe main function has received this number " << result
            << " and will keep it for future reference.\nThe main function will return a zero to the operating system.\n" << std::endl;
    
    return 0;
}