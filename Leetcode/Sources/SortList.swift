//
//  Sort.swift
//  Leetcode
//
//  Created by xyz on 2023/7/1.
//

import Foundation

class SortList<T> {

    static func bubbleSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
        var s = list
        for i in 0 ..< s.count - 1 {
            for j in 0 ..< s.count - i - 1 {
                if compare(s[j], s[j + 1]) {
                    let p = s[j]
                    s[j] = s[j + 1]
                    s[j + 1] = p
                }
            }
        }
        return s
    }
    
    static func selectionSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
        var s = list
        for i in 0 ..< s.count - 1 {
            var k = i
            for j in i + 1 ..< s.count {
                if compare(s[k], s[j]) {
                    k = j
                }
            }
            if i != k {
                let p = s[i]
                s[i] = s[k]
                s[k] = p
            }
        }
        return s
    }
    
    static func insertionSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
        var s = list
        for i in 0 ..< s.count {
            var j = i
            while j > 0 {
                if compare(s[j - 1], s[j]) {
                    let p = s[j]
                    s[j] = s[j - 1]
                    s[j - 1] = p
                    j -= 1
                } else {
                    break
                }
            }
        }
        return s
    }

    static func shellSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
        var s = list
        return s
    }
    
    static func quickSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
        var s = list
        return s
    }
    
    static func mergeSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
        var s = list
        return s
    }
    
    static func heapSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
        var s = list
        return s
    }
    
    static func countingSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
        var s = list
        return s
    }
    
    static func bucketSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
        var s = list
        return s
    }
    
    static func radixSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
        var s = list
        return s
    }
}
