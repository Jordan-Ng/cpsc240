//****************************************************************************************************************************
//Program name: "Pythagoras".  This program takes in the user input of two sides of a triangle in float and calculates 
// the hypotenuse. Copyright (C) 2023 Jia Wei Ng.                                                                             *
//                                                                                                                           *
//This file is part of the software program "Pythagoras".                                                                   *
//Pythagoras is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
//version 3 as published by the Free Software Foundation.                                                                    *
//Pythagoras is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Jia Wei Ng
//  Author email: JiaWei.Ng@csu.fullerton.edu
//
//Program information
//  Program name: Jia Wei Ng
//  Programming languages: One modules in C++ and one module in X86
//  Date program began: 2023 Jan 24
//  Date of last update: 2023 Feb 4
//  Files in this program: driver.cpp, pythagoras.asm
//  Status: Finished.
//
//Purpose
//  Show how to input and output floating point (64-bit) numbers.
//
//This file
//   File name: driver.cpp
//   Language: C++
//   Max page width: 133 columns
//   Compile: g++ -c -Wall -m64 -no-pie -o driver.o driver.cpp -std=c++2a
//   Link: g++ -m64 -no-pie -fno-pie -o pythagoras.out driver.o pythagoras.o -std=c++2a
//   Optimal print specification: 133 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================

#include <iostream>
#include <string>
#include <iomanip>

extern "C" double hypotenuse();

int main(){
  std::cout<< "Welcome to Pythagoras' Math Lab programmed by Jia Wei Ng \n"
	<< "Please contact me at JiaWei.Ng@csu.fullerton.edu if you need assistance\n\n";

  double length;
  length = hypotenuse();

  std::cout << std::setprecision(12) << "\nThe main file received this number: " << length << ", and will keep it for now.\n"
	<< "We hoped you enjoyed your right angles. Have a good day. A zero will be sent to your operating system\n";

 return 0;
}

