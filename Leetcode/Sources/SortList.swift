//
//  Sort.swift
//  Leetcode
//
//  Created by xyz on 2023/7/1.
//

import Foundation

class SortList<T> {
    
    static func bubbleSort(_ list: [T], _ sort: (T,T) -> Bool) -> [T] {
        if list.count < 2 { return list }
        var s = list
        for i in 0 ..< s.count - 1 {
            for j in 0 ..< s.count - i - 1 {
                if sort(s[j + 1], s[j]) {
                    let p = s[j]
                    s[j] = s[j + 1]
                    s[j + 1] = p
                    print("[\(j),\(j + 1)]\(s)")
                }
            }
        }
        return s
    }
    
    static func selectionSort(_ list: [T], _ sort: (T,T) -> Bool) -> [T] {
        if list.count < 2 { return list }
        var s = list
        for i in 0 ..< s.count - 1 {
            var k = i
            for j in i + 1 ..< s.count {
                if sort(s[j], s[k]) {
                    k = j
                }
            }
            if i != k {
                let p = s[i]
                s[i] = s[k]
                s[k] = p
                print("[\(i),\(k)]\(s)")
            }
        }
        return s
    }
    
    static func insertionSort(_ list: [T], _ sort: (T,T) -> Bool) -> [T] {
        if list.count < 2 { return list }
        var s = list
        for i in 0 ..< s.count {
            var j = i
            while j > 0 {
                if sort(s[j], s[j - 1]) {
                    let p = s[j]
                    s[j] = s[j - 1]
                    s[j - 1] = p
                    j -= 1
                    print("[\(j - 1),\(j)]\(s)")
                } else {
                    break
                }
            }
        }
        return s
    }

    static func shellSort(_ list: [T], _ sort: (T,T) -> Bool) -> [T] {
        if list.count < 2 { return list }
        var s = list, j = 0, k = 0, gap = s.count / 2
        while gap > 0 {
            for i in gap ..< s.count {
                j = i - gap
                while j >= 0 {
                    k = j + gap
                    //print("{gap:\(gap) i:\(i), j:\(j)[\(s[j])], k:\(k)[\(s[k])]}")
                    if sort(s[k], s[j]) {
                        let p = s[j]
                        s[j] = s[k]
                        s[k] = p
                        print("[\(j),\(k)]\(s)")
                    }
                    j -= gap
                }
            }
            gap = gap / 2
        }
        return s
    }
    
    static func mergeSort(_ list: [T], _ sort: (T,T) -> Bool) -> [T] {
        if list.count < 2 { return list }
        var s = list
        var i = 1
        while i < s.count {
            var j = 0
            var t = [T]()
            while j < s.count {
                var l = j, r = i + j
                while l < i + j, r < i + i + j, r < s.count {
                    if sort(s[r], s[l]) {
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
    
    static func quickSort(_ list: [T], _ sort: (T,T) -> Bool) -> [T] {
        if list.count < 2 { return list }
        var s = list
        quick_sort(&s, sort, 0, s.count - 1)
        return s
    }
    
    static func quick_sort(_ s: inout [T], _ sort: (T,T) -> Bool, _ left: Int, _ right: Int) {
        guard left < right else { return }
        var l = left, r = right
        let mid = s[l]
        while l < r {
            while l < r, !sort(s[r], mid) {
                r -= 1
            }
            if l < r {
                s[l] = s[r]
                print("[\(r),\(l)]\(s)")
                l += 1
            }
            //
            while l < r, sort(s[l], mid) {
                l += 1
            }
            if l < r {
                s[r] = s[l]
                print("[\(l),\(r)]\(s)")
                r -= 1
            }
        }
        s[l] = mid
        print("[\(left),\(l)]\(s)")
        //
        quick_sort(&s, sort, left, l - 1)
        quick_sort(&s, sort, l + 1, right)
    }
    
    static func heapSort(_ list: [T], _ sort: (T,T) -> Bool) -> [T] {
        var list = list
        // build max heap
        var i = list.count / 2 - 1
        while i >= 0 {
            heapify(&list, sort, list.count, i)
            i -= 1
        }
        // Heap sort
        var j = list.count - 1
        while j >= 0 {
            let h = list[0]
            list[0] = list[j]
            list[j] = h
            print("[0,\(j)] \(list)")
            //
            heapify(&list, sort, j, 0)
            j -= 1
        }
        return list
    }
    
    static func heapify(_ list: inout [T], _ sort: (T,T) -> Bool, _ len: Int, _ i: Int) {
        let l = i + i + 1
        let r = l + 1
        var j = i
        if l < len, sort(list[i], list[l]) {
            j = l
        }
        if r < len, sort(list[j], list[r]) {
            j = r
        }
        if i != j {
            let p = list[i]
            list[i] = list[j]
            list[j] = p
            print("[\(i),\(j)] \(list)")
            //
            heapify(&list, sort, len, j)
        }
    }
    
    static func countingSort(_ list: [Int]) -> [Int] {
        if list.count < 2 { return list }
        var n = -1
        for i in list {
            if n < i {
                n = i
            }
        }
        if n < 0 { return [] }
        var s = [Int](repeating: 0, count: n + 1)
        for i in list {
            if i >= 0 && i <= n {
                s[i] += 1
            }
        }
        var t = [Int]()
        for i in 0 ... n {
            for _ in 0 ..< s[i] {
                t.append(i)
            }
        }
        return t
    }
    
    static func bucketSort(_ list: [Int]) -> [Int] {
        if list.count < 2 { return list }
        var max = 0, min = 0
        for i in list {
            if max < i {
                max = i
            }
            if min > i {
                min = i
            }
        }
        let mid = (min + max) / 2
        var lo = [Int]()
        var hi = [Int]()
        for i in list {
            if i <= mid {
                lo.append(i)
            } else {
                hi.append(i)
            }
        }
        lo = SortList<Int>.quickSort(lo, { (m, n) -> Bool in
            return m < n
        })
        hi = SortList<Int>.quickSort(hi, { (m, n) -> Bool in
            return m < n
        })
        lo.append(contentsOf: hi)
        return lo
    }
    
    static func radixSort(_ list: [Int]) -> [Int] {
        if list.count < 2 { return list }
        var list = list
        var digits = [Int:[Int]]()
        var length = 0
        for i in 0 ..< list.count {
            var num = list[i]
            var nums = [Int]()
            while num > 0 {
                nums.append(num % 10)
                num /= 10
            }
            digits[list[i]] = nums
            if length < nums.count {
                length = nums.count
            }
        }
        var buckets = [[Int]](repeating: [Int](), count: 10)
        var radix = 1
        for i in 0 ..< length {
            for j in 0 ..< list.count {
                let num = list[j]
                if num >= radix {
                    let digit = digits[num]![i]
                    buckets[digit].append(num)
                } else {
                    buckets[0].append(num)
                }
            }
            list.removeAll()
            for k in 0 ..< buckets.count {
                for num in buckets[k] {
                    list.append(num)
                }
                buckets[k].removeAll()
            }
            print("[\(radix)]\(list)")
            radix *= 10
        }
        return list
    }
}
