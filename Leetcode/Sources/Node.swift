//
//  Node.swift
//  Leetcode
//
//  Created by xyz on 2023/7/22.
//

import Foundation

public class Node {
    public var val: Int
    
    public var next: Node?
    
    public var left: Node?
    public var right: Node?
    
    public var random: Node?
    
    public var neighbors: [Node?]
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
        self.left = nil
        self.right = nil
        self.random = nil
        self.neighbors = []
    }
}

extension Node {
    static public func buildNode(_ list: [Int]) -> Node? {
        var nodes = [Node?]()
        for val in list {
            nodes.append(Node(val))
        }
        for i in 0 ..< list.count {
            let node = nodes[i]
            let left = i * 2 + 1
            if left < list.count {
                node?.left = nodes[left]
            }
            let right = i * 2 + 2
            if right < list.count {
                node?.right = nodes[right]
            }
        }
        return nodes.isEmpty ? nil : nodes[0]
    }
    
    static public func buildRandomNode(_ list: [[Int?]]) -> Node? {
        var nodes = [Node]()
        for i in 0 ..< list.count {
            let vals = list[i]
            if vals.count > 0, let val = vals[0] {
                let node = Node(val)
                nodes.append(node)
                if i > 0 {
                    nodes[i - 1].next = node
                }
            }
        }
        for i in 0 ..< list.count {
            let vals = list[i]
            if vals.count > 1, let j = vals[1], j >= 0, j < nodes.count {
                nodes[i].random = nodes[j]
            }
            
        }
        return nodes.first
    }
    
    static public func printNode(_ node: Node?) {
        var level = ""
        let queue = Queue<Node>()
        queue.push(node)
        while !queue.isEmpty {
            let count = queue.count
            for _ in 0 ..< count {
                if let node = queue.pop() {
                    if !level.isEmpty {
                        level += ","
                    }
                    level += "\(node.val)"
                    queue.push(node.left)
                    queue.push(node.right)
                }
            }
            level += ",#"
        }
        print(level)
    }
}
