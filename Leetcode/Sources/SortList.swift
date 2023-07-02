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
                    print(s)
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
                print(s)
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
                    print(s)
                } else {
                    break
                }
            }
        }
        return s
    }

    static func shellSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
        var s = list, j = 0, k = 0, gap = s.count / 2
        while gap > 0 {
            for i in gap ..< s.count {
                j = i - gap
                while j >= 0 {
                    k = j + gap
                    //print("{gap:\(gap) i:\(i), j:\(j)[\(s[j])], k:\(k)[\(s[k])]}")
                    if compare(s[j], s[k]) {
                        let p = s[j]
                        s[j] = s[k]
                        s[k] = p
                        print(s)
                    }
                    j -= gap
                }
            }
            gap = gap / 2
        }
        return s
    }
    
    static func mergeSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
        if list.count < 2 { return list }
        var s = list
        var i = 1
        while i < s.count {
            var j = 0
            var t = [T]()
            while j < s.count {
                var l = j, r = i + j
                while l < i + j, r < i + i + j, r < s.count {
                    if compare(s[l], s[r]) {
                        t.append(s[r])
                        r += 1
                    } else {
                        t.append(s[l])
                        l += 1
                    }
                    print(t)
                }
                while l < i + j, l < s.count {
                    t.append(s[l])
                    l += 1
                }
                while r < i + i + j, r < s.count {
                    t.append(s[r])
                    r += 1
                }
                j += i + i
                print(t)
            }
            i += i
            s = t
        }
        return s
    }
    
    static func quickSort(_ list: [T], _ compare: (T,T) -> Bool) -> [T] {
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
