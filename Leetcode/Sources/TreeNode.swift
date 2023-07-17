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
    static public func make(_ list: [Int?]) -> TreeNode? {
        var trees = [TreeNode?]()
        for val in list {
            if let val = val {
                trees.append(TreeNode(val))
            } else {
                trees.append(nil)
            }
        }
        for i in 0 ..< list.count {
            let tree = trees[i]
            let left = i * 2 + 1
            if left < list.count {
                tree?.left = trees[left]
            }
            let right = i * 2 + 2
            if right < list.count {
                tree?.right = trees[right]
            }
        }
        return trees.isEmpty ? nil : trees[0]
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
    
    func levelorderTraversal(_ values: inout [Int], isFBT: Bool = false) {
        var list = [TreeNode]()
        list.append(self)
        while !list.isEmpty {
            let tree = list.first!
            values.append(tree.val)
            list.removeFirst()
            if let left = tree.left {
                list.append(left)
            }
            if let right = tree.right {
                list.append(right)
            }
        }
    }
    
    func levelorderTraversalFBT(_ values: inout [Int?]) {
        var list = [TreeNode]()
        list.append(self)
        while !list.isEmpty {
            let tree = list.first!
            values.append(tree.val)
            list.removeFirst()
            if let left = tree.left {
                list.append(left)
            } else {
                values.append(nil)
            }
            if let right = tree.right {
                list.append(right)
            } else {
                values.append(nil)
            }
        }
    }
}

extension TreeNode {
    static func BSTInsert(_ tree: TreeNode?, _ x: Int) -> TreeNode? {
        var tree = tree
        if tree == nil {
            tree = TreeNode(x)
        } else if x < tree!.val {
            tree?.left = TreeNode.BSTInsert(tree?.left, x)
        } else if x > tree!.val {
            tree?.right = TreeNode.BSTInsert(tree?.right, x)
        }
        return tree
    }
    
    static func BSTSearch(_ tree: TreeNode?, _ x: Int) -> TreeNode? {
        var tree = tree
        while tree != nil {
            if x < tree!.val {
                tree = tree!.left
            } else if x > tree!.val {
                tree = tree!.left
            } else { //if tree!.val == x {
                return tree
            }
        }
        return nil
    }
}
