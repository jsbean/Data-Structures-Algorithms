//
//  main.cpp
//  rod_cutting_algorithm
//
//  given a rod length n and list of prices p_i of the value of rods of length 1, 2, ..., n,
//  return the maximum value possible given unlimited free cuts.
//
//  From Introduction to Algorithms (CLRS), 3rd Ed., pp 364-7.
//
//  Created by Brian Heim on 12/26/16.
//  Copyright © 2016 Brian Heim. All rights reserved.
//

#include <iostream>
#include <algorithm>

#define MAXSIZE 20

int memoized_cut_rod(int p[], int n);
int memoized_cut_rod_aux(int p[], int n, int r[]);
int bottom_up_cut_rod(int p[], int n);
int ext_bottom_up_cut_rod(int p[], int n, int r[], int s[]);

int main(int argc, const char * argv[]) {
    
    argv++; // get past cd argument
    
    if(!*argv) {
        printf("Error: need a first argument.\n");
        return 1;
    }
    
    int n = atoi(*argv++);
    
    if(n <= 0 || n > MAXSIZE) {
        printf("Error: first argument must be between %d and %d.\n", 1, MAXSIZE);
        return 1;
    }
    
    int p[MAXSIZE];
    
    for(int i = 0; i < n; i++, argv++) {
        if(!*argv) {
            printf("Error: only %d price arguments supplied but need %d.\n", i, n);
            return 1;
        }
        
        p[i] = atoi(*argv);
    }
    
    printf("answer: %d\n", bottom_up_cut_rod(p, n));
    
    return 0;
}

int memoized_cut_rod(int p[], int n) {
    int r[MAXSIZE + 1];
    
    for(int i = 0; i <= n; i++)
        r[i] = INT_MIN;
    
    int result = memoized_cut_rod_aux(p, n, r);
    
    for(int i = 0; i <= n; i++)
        printf("%d ", r[i]);
    
    printf("\n");
    
    return result;
}

int memoized_cut_rod_aux(int p[], int n, int r[]) {
    if(r[n] >= 0)
        return r[n];
    
    int q;
    
    if(n == 0)
        q = 0;
    else {
        q = INT_MIN;
        for(int i = 1; i <= n; i++)
            q = std::max(q, p[i-1] + memoized_cut_rod_aux(p, n-i, r));
    }
    
    r[n] = q;
    
    return q;
}

int bottom_up_cut_rod(int p[], int n) {
    int r[MAXSIZE + 1];
    
    r[0] = 0;
    
    for(int j = 1; j <= n; j++) {
        int q = INT_MIN;
        
        for(int i = 1; i <= j; i++) {
            q = std::max(q, p[i - 1] + r[j - i]);
        }
        
        r[j] = q;
    }
    
    return r[n];
}

int ext_bottom_up_cut_rod(int p[], int n, int r[], int s[]) {
    r[0] = 0;
    
    for(int j = 1; j <= n; j++) {
        int q = INT_MIN;
        
        for(int i = 1; i <= j; i++) {
            if(q < p[i - 1] + r[j - i]) {
                q = p[i - 1] + r[j - 1];
                s[j] = i; // record best cut
            }
        }
        
        r[j] = q; // record value
    }
    
    return r[n];
}
