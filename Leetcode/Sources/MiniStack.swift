//
//  MiniStack.swift
//  Leetcode
//
//  Created by xyz on 2023/8/3.
//

import Foundation

class MinStack {
    var stack = [(Int,Int)]()

    init() {}
    
    func push(_ val: Int) {
        var preMinVal = Int.max
        if let (_,minV) = stack.last {
            preMinVal = minV
        }
        stack.append((val, min(val, preMinVal)))
    }
    
    func pop() {
        let _ = stack.removeLast()
    }
    
    func top() -> Int {
        if let (val,_) = stack.last {
            return val
        }
        return 0
    }
    
    func getMin() -> Int {
        if let (_,minV) = stack.last {
            return minV
        }
        return 0
    }
    
}
