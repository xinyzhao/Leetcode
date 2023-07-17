//
//  Queue.swift
//  Leetcode
//
//  Created by xyz on 2023/7/17.
//

import Foundation

/// FIFO/LILO Queue
open class Queue<T> {
    public var list = [T]()
    public var count: Int { return list.count }
    public var isEmpty: Bool { return count == 0 }
    public init() {}
    
    open func push(_ element: T?) { if let e = element { list.append(e) } }
    open func pop() -> T? { list.isEmpty ? nil : list.removeFirst() }
    open func first() -> T? { list.first }
    open func last() -> T? { list.last }
}
