//
//  main.swift
//  matrix_chain_order_swift
//
//  Created by Brian Heim on 1/8/17.
//  Copyright © 2017 Brian Heim. All rights reserved.
//

import Foundation

func chainOrder(dimensions: [Int]) -> (Matrix<Int>, Matrix<Int>) {
    
    let n = dimensions.count - 1
    
    var multiplications = Matrix(height: n, width: n, initial: 0)
    var splits = Matrix(height: n - 1, width: n - 1, initial: 0)
    
    // Try every possible chain length
    for chainLength in 2 ... n {
        
        // Try every possible left index given the chain length
        for left in 0 ..< (n - chainLength) {
            
            // Infer right bound
            let right = left + chainLength - 1
            
            // Try to find the minimum number of multiplications
            multiplications[left, right] = Int.max
            
            // Try every possible index for splitting the chain
            for mid in left ..< right {
                
                // TODO: Consider making a helper function for this
                // New possible minimum = number of multiplications needed to get to this point
                // Plus the number of multiplications needed to multiply the two resulting 
                // matrices
                let x = (
                    (multiplications[left, mid] + multiplications[mid + 1, right]) +
                    (dimensions[left] * dimensions[mid + 1] * dimensions[right + 1])
                )
                
                // Store a new minimum
                if x < multiplications[left, right] {
                    multiplications[left, right] = x
                    splits[left, right - 1] = mid
                }
            }
        }
    }
    
    return (multiplications, splits)
}

let (multiplications, splits) = chainOrder(dimensions:[30, 35, 15, 5, 10, 20, 25])

print("Multiplications:")
print(multiplications)
print()
print("Splits:")
print(splits)
