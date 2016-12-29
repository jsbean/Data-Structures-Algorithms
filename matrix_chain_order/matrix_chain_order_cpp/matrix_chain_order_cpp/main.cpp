//
//  main.cpp
//  matrix_chain_order_cpp
//
//  Created by Brian Heim on 12/28/16.
//  Copyright © 2016 Brian Heim. All rights reserved.
//

#include "matrix_chain_header.h"

#include <iostream>

#define NUM_MATRICES 6

int main(int argc, const char * argv[]) {
    
    int n = NUM_MATRICES;
    int p[NUM_MATRICES+1] = {30, 35, 15, 5, 10, 20, 25};
    
    int m[MAX_MATRICES][MAX_MATRICES];
    int s[MAX_MATRICES-1][MAX_MATRICES-1];
    
    std::cout << matrix_chain_order(n, p, m, s) << std::endl;
    return 0;
}

