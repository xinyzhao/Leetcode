//
//  Tree.swift
//  Leetcode
//
//  Created by xyz on 2023/7/25.
//

import Foundation

public class Tree<T> {
    public var value: T
    public var child = [Tree<T>]()
    public init(_ value: T) { self.value = value }
    public init(_ value: T, _ list: [T]) {
        self.value = value
        for val in list {
            child.append(Tree(val))
        }
    }
}

extension Tree {
    public func print() {
        var trees = [[T]]()
        let queue = Queue<Tree>()
        queue.push(self)
        while !queue.isEmpty {
            let count = queue.count
            var level = [T]()
            for _ in 0 ..< count  {
                if let tree = queue.pop() {
                    level.append(tree.value)
                    for child in tree.child {
                        queue.push(child)
                    }
                }
            }
            trees.append(level)
        }
        Swift.print(trees)
    }
}
