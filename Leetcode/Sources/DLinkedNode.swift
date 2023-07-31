//
//  DoubleLinkedList.swift
//  Leetcode
//
//  Created by xyz on 2023/7/31.
//

import Foundation

public class DLinkedNode {
    public var key = 0
    public var value = 0
    public var prev: DLinkedNode?
    public var next: DLinkedNode?
    public init(_ key: Int, _ value: Int) { self.key = key; self.value = value; }
}
