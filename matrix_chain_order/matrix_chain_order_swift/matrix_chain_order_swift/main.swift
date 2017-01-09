//
//  main.swift
//  matrix_chain_order_swift
//
//  Created by Brian Heim on 1/8/17.
//  Copyright © 2017 Brian Heim. All rights reserved.
//

import Foundation

func matrixChainOrder(dimensions: [Int]) -> (multiplications: [[Int]], splits: [[Int]]) {
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
                var x = multiplications[left][mid] + multiplications[mid + 1][right]
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





/// - note: Puts the given `separator` between elements of the nested array.
func format <T> (_ array: [[T]], separator: String = "  ") -> String {
    
    /// Returns the width of a string-interpolated representation of any value.
    ///
    /// - warning: Assumes primitive type with no fancier `CustomStringConvertible` implementation.
    func width(_ value: Any) -> Int {
        return "\(value)".characters.count
    }
    
    /// - returns: Whitespace with the given width.
    func space(_ amount: Int) -> String {
        return String(repeating: " ", count: amount)
    }
    
    /// - returns: Maximum column width of 2D array.
    ///
    /// - note: Assumes length of each subarrays are equivalent
    /// - note: Assumes `T` values don't have a complex `CustomStringConvertible` implementation.
    func columnWidth <T> (_ array: [[T]]) -> Int {
        
        guard !array.isEmpty else {
            return 0
        }
        
        return (0 ..< array[0].count)
            .flatMap { column in array.flatMap { row in width(row[column]) }.max() }
            .max() ?? 0
    }

    /// - warning: Don't use `\t`, though. Doesn't register correctly.
    func format <T> (_ array: [T], columnWidth: Int, separator: String = "  ") -> String {
        return array.map { "\($0)\(separator)\(space(columnWidth - width($0)))" }.joined()
    }
    
    return array
        .map { format($0, columnWidth: columnWidth(array), separator: separator) }
        .joined(separator: "\n")
}

let result = matrixChainOrder(dimensions:[30, 35, 15, 5, 10, 20, 25])

print("Multiplications:")
print(format(result.multiplications))
print()
print("Splits:")
print(format(result.splits))
