//****************************************************************************************************************************
//Program name: "Random Arrays".  This program takes in an array size input, fills the array with random 64-bit numbers,
//sorts the array, then normalizes it . Copyright (C) 2023 Jia Wei Ng.                                                                             *
//                                                                                                                           *
//This file is part of the software program "Random Arrays".                                                                   *
//Random Arrays is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
//version 3 as published by the Free Software Foundation.                                                                    *
//Random Arrays is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
//  Programming languages: 2 modules in C++, 4 modules in assembly
//  Date program began: 2023 Feb 20
//  Date of last update: 2023 Mar 12
//  Files in this program: main.cpp, quick_sort.cpp, isNan.asm, display_array.asm, executive.asm, fill_random_array.asm,
//  Status: Finished.
//
//Purpose
//  Show how to delegate tasks between modules (passing arguments, retrieving return values)
//
//This file
//   File name: main.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: g++ -c -m64 -Wall -no-pie -fno-pie -std=c++2a main.cpp -o main.o
//   Link: g++ -m64 -Wall -no-pie -fno-pie -std=c++2a *.o -o main.out
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================
#include <iostream>
#include <string>

extern "C" char * executive();

int main(){
    std::cout << "Welcome to Random Products, LLC. \nThis software is maintained by Jia Wei Ng" <<std::endl;

    char * fullName = executive();
    std::cout << "Oh, "<< fullName << ". We hope you enjoyed your arrays. Do come again.\nA zero will be returned to the operating system." << std::endl;

    return 0;
}