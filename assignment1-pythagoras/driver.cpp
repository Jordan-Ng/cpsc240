#include <iostream>
#include <string>
#include <iomanip>

extern "C" double hypotenuse();

int main(){
  std::cout<< "Welcome to Pythagoras' Math Lab programmed by Jia Wei Ng \n"
	<< "Please contact me at JiaWei.Ng@csu.fullerton.edu if you need assistance\n\n";

  double length;
  length = hypotenuse();

  std::cout << "The main file received this number:  " << length << ", and will keep it for now.\n"
	<< "We hoped you enjoyed your right angles. Have a good day. A zero will be sent to your operating system\n";

 return 0;
}

