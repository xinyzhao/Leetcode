//
//  LRUCache.swift
//  Leetcode
//
//  Created by xyz on 2023/7/31.
//

import Foundation

class LRUCache {
    var capacity = 0
    var cache = [Int:DLinkedNode]()
    var head = DLinkedNode(0,0)
    var tail = DLinkedNode(0,0)

    init(_ capacity: Int) {
        self.capacity = capacity
        head.next = tail
        tail.prev = head
    }
    
    func get(_ key: Int) -> Int {
        if let node = cache[key] {
            node.prev?.next = node.next
            node.next?.prev = node.prev
            node.prev = head
            node.next = head.next
            head.next?.prev = node
            head.next = node
            return node.value
        }
        return -1
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            node.prev?.next = node.next
            node.next?.prev = node.prev
            node.value = value
            //
            node.prev = head
            node.next = head.next
            head.next?.prev = node
            head.next = node
        } else {
            let node = DLinkedNode(key, value)
            //
            node.prev = head
            node.next = head.next
            head.next?.prev = node
            head.next = node
            //
            cache[key] = node
            //
            if cache.count > capacity {
                let node = tail.prev
                node?.prev?.next = node?.next
                node?.next?.prev = node?.prev
                cache.removeValue(forKey: node!.key)
            }
        }
    }
}
