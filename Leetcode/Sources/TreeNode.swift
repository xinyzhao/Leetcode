//
//  TreeNode.swift
//  Leetcode
//
//  Created by xyz on 2023/7/15.
//

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

extension TreeNode {
    func preorderTraversal(_ values: inout [Int]) {
        values.append(val)
        left?.preorderTraversal(&values)
        right?.preorderTraversal(&values)
    }
    
    func inorderTraversal(_ values: inout [Int]) {
        left?.inorderTraversal(&values)
        values.append(val)
        right?.inorderTraversal(&values)
    }
    
    func postorderTraversal(_ values: inout [Int]) {
        left?.postorderTraversal(&values)
        right?.postorderTraversal(&values)
        values.append(val)
    }
}

extension TreeNode {
    func binarySearchTreeSearch(_ x: Int) -> TreeNode? {
        if val == x {
            return self
        }
        if x < val {
            return left?.binarySearchTreeFind(x)
        } else if x > val {
            return right?.binarySearchTreeFind(x)
        }
        return nil
    }
}
