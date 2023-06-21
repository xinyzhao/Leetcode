import Foundation

public class Solution {
    public init() {}
    
    public func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var list = [Int:Int]()
        for i in 0 ..< nums.count {
            let n = nums[i]
            let x = target - n
            if let j = list[x] {
                return [j,i]
            }
            list[n] = i
        }
        return []
    }
    
    public func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var root: ListNode?
        var next: ListNode?
        var plus: Int = 0
        var p1 = l1
        var p2 = l2
        repeat {
            var val: Int = plus
            if let v1 = p1?.val {
                val += v1
            }
            if let v2 = p2?.val {
                val += v2
            }
            if val >= 10 {
                val -= 10
                plus = 1
            } else {
                plus = 0
            }
            //
            let node = ListNode(val)
            if root == nil {
                root = node
            } else {
                if root?.next == nil {
                    root?.next = node
                } else {
                    next?.next = node
                }
                next = node
            }
            //
            p1 = p1?.next
            p2 = p2?.next
        } while (p1 != nil || p2 != nil || plus > 0)
        //
        return root
    }
    
    public func lengthOfLongestSubstring(_ s: String) -> Int {
        let str = Array(s)
        var set = Array(repeating: -1, count: 128)
        var len = 0
        var start = 0
        for i in 0 ..< str.count {
            let char = str[i]
            let idx = Int(char.asciiValue ?? 0)
            let pre = set[idx]
            start = max(start, pre + 1)
            len = max(len, i - start + 1)
            set[idx] = i
        }
        return len
    }
}
