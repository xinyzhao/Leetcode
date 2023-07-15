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
    func binarySearchTreeInsert(_ tree: TreeNode?, _ x: Int) -> TreeNode? {
        var tree = tree
        if tree == nil {
            tree = TreeNode(x)
        } else if x < tree!.val {
            tree?.left = tree?.binarySearchTreeInsert(tree?.left, x)
        } else if x > tree!.val {
            tree?.right = tree?.binarySearchTreeInsert(tree?.right, x)
        }
        return tree
    }
    
    func binarySearchTreeSearch(_ x: Int) -> TreeNode? {
        if val == x {
            return self
        }
        if x < val {
            return left?.binarySearchTreeSearch(x)
        } else if x > val {
            return right?.binarySearchTreeSearch(x)
        }
        return nil
    }
}
