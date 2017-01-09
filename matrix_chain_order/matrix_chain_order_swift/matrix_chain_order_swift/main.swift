//
//  main.swift
//  matrix_chain_order_swift
//
//  Created by Brian Heim on 1/8/17.
//  Copyright © 2017 Brian Heim. All rights reserved.
//

import Foundation

func matrix_chain_order(dimensions: [Int]) -> (multiplications: [[Int]], splits: [[Int]]) {
    let n = dimensions.count - 1
    var multiplications = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    var splits = [[Int]](repeating: [Int](repeating: 0, count: n - 1), count: n - 1)
    
    // try every possible chain length
    for chainLength in 2...n {
        // try every possible left index given the chain length
        for left in 0...n-chainLength {
            // the right bound is inferred from the left index
            let right = left + chainLength - 1
            // try to find the minimum number of multiplications
            multiplications[left][right] = Int.max
            // try every possible index for splitting the chain
            for mid in left...right-1 {
                // new possible minimum = number of multiplications needed to get to this point
                var x : Int = multiplications[left][mid] + multiplications[mid + 1][right]
                // plus the number of multiplications needed to multiply the two resulting matrices
                x += dimensions[left] * dimensions[mid + 1] * dimensions[right + 1]
                // store a new minimum
                if x < multiplications[left][right] {
                    multiplications[left][right] = x
                    splits[left][right - 1] = mid
                }
            }
        }
    }
    
    return (multiplications, splits)
}

func format <T> (_ array: Array<Array<T>>, separator: String = "") -> String {
    return array.map { format($0, separator: separator) }.joined(separator: "\n")
}

func format <T> (_ array: Array<T>, separator: String = "") -> String {
    return array.map { "\($0)" }.joined(separator: separator)
}

let result = matrix_chain_order(dimensions:[30, 35, 15, 5, 10, 20, 25])
print("multiplications:")
print(format(result.multiplications, separator: ",\t"))
print()
print("splits:")
print(format(result.splits, separator: "\t"))
