//
//  BSTIterator.swift
//  Leetcode
//
//  Created by xyz on 2023/8/6.
//

import Foundation

class BSTIterator {
    var stack = Stack<TreeNode>()
    var tree: TreeNode?
    
    init(_ root: TreeNode?) {
        tree = root
    }
    
    func next() -> Int {
        while tree != nil {
            stack.push(tree)
            tree = tree?.left
        }
        tree = stack.pop()
        let ret = tree?.val ?? 0
        tree = tree?.right
        return ret
    }
    
    func hasNext() -> Bool {
        return tree != nil || !stack.isEmpty
    }
    
}
