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
    func preOrderValues(_ values: inout [Int]) {
        values.append(val)
        left?.preOrderValues(&values)
        right?.preOrderValues(&values)
    }
    
    func middleOrderValues(_ values: inout [Int]) {
        left?.middleOrderValues(&values)
        values.append(val)
        right?.middleOrderValues(&values)
    }
    
    func postOrderValues(_ values: inout [Int]) {
        left?.postOrderValues(&values)
        right?.postOrderValues(&values)
        values.append(val)
    }
}
