//
//  matrix_chain_header.h
//  matrix_chain_order_cpp
//
//  Created by Brian Heim on 12/28/16.
//  Copyright © 2016 Brian Heim. All rights reserved.
//


#ifndef matrix_chain_header_h
#define matrix_chain_header_h

#include <limits.h>

#define MAX_MATRICES 10

int matrix_chain_order(int n, int *p, int m[][MAX_MATRICES], int s[][MAX_MATRICES-1]) {
    // n is p.length - 1
    for(int i = 0; i < n; i++) {
        m[i][i] = 0;
    };
    
    int i, j, k, l, q;
    
    for(l = 2; l <= n; l++)
        for(i = 0; i <= n - l; i++) {
            m[i][j = i+l-1] = INT_MAX;
            for(k = i; k < j; k++)
                if((q = m[i][k] + m[k+1][j] + p[i]*p[k+1]*p[j+1]) < m[i][j])
                    m[i][j] = q, s[i][j] = k;
        }
    
    return m[0][n-1];
}

#endif /* matrix_chain_header_h */
