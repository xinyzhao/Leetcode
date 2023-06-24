import Foundation

class Solution {
    init() {}
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
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
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
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
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
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
    
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var l = 0, r = 0
        var i = 0, j = 0
        var m = nums1.count - 1
        var n = nums2.count - 1
        let y = (nums1.count + nums2.count + 1) / 2
        for _ in 0 ..< y {
            if i <= m, j <= n {
                if nums1[i] < nums2[j] {
                    l = nums1[i]
                    i += 1
                } else {
                    l = nums2[j]
                    j += 1
                }
                if nums1[m] > nums2[n] {
                    r = nums1[m]
                    m -= 1
                } else {
                    r = nums2[n]
                    n -= 1
                }
            } else if i <= m {
                l = nums1[i]
                r = nums1[m]
                i += 1
                m -= 1
            } else {
                l = nums2[j]
                r = nums2[n]
                j += 1
                n -= 1
            }
        }
        return Double(l + r) / 2.0
    }
    
    func longestPalindrome(_ s: String) -> String {
        let arr = Array(s)
        let str = s as NSString
        var range = NSMakeRange(0, 0)
        for i in 0 ..< arr.count {
            var l = i - 1
            var r = i + 1
            var len = 1 //首个字符必为回文
            while l >= 0, arr[l] == arr[i] {
                l -= 1
                len += 1
            }
            while r < arr.count, arr[r] == arr[i] {
                r += 1
                len += 1
            }
            while l >= 0, r < arr.count, arr[l] == arr[r] {
                l -= 1 //l == 0时会变成 -1，下面记得加回来
                r += 1
                len += 2
            }
            if range.length < len {
                range.location = l
                range.length = len
            }
        }
        range.location += 1
        return str.substring(with: range)
    }
    
    func convert(_ s: String, _ numRows: Int) -> String {
        if numRows == 1 { return s}
        var arr = [String]()
        for _ in 0 ..< numRows {
            arr.append("")
        }
        var dir = -1
        var row = 0
        for c in s {
            arr[row] += "\(c)"
            if row == 0 || row == numRows - 1 {
                dir = -dir
            }
            row += dir
        }
        var str = ""
        for s in arr {
            str += s
        }
        return str
    }
    
    func reverse(_ x: Int) -> Int {
        var x = x
        var y = 0
        while x != 0 {
            if y > (Int32.max / 10) || y < (Int32.min / 10) {
                return 0
            }
            y *= 10
            y += x % 10
            x /= 10
        }
        return y
    }
    
    func myAtoi(_ s: String) -> Int {
        var n = 0
        let arr = Array(s)
        var signed = 1
        var started = false
        let zero = Character("0").asciiValue ?? 0
        let nine = Character("9").asciiValue ?? 0
        for c in arr {
            if c == " " {
                if started {
                    break
                }
                continue
            }
            if c == "+" {
                if started {
                    break
                }
                started = true
                signed = 1
                continue
            }
            if c == "-" {
                if started {
                    break
                }
                started = true
                signed = -1
                continue
            }
            if let ascii = c.asciiValue {
                if ascii >= zero, ascii <= nine {
                    started = true
                    n *= 10
                    n += Int(ascii - zero)
                    if n * signed > Int32.max {
                        n = Int(Int32.max) * signed
                        break
                    } else if n * signed < Int32.min {
                        n = Int(Int32.min) * signed
                        break
                    }
                } else {
                    break
                }
            }
        }
        return n * signed
    }
    
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 { return false }
        var a = x
        var b = 0
        while a != 0 {
            b = (b * 10) + (a % 10)
            a /= 10
        }
        return x == b
    }
    
    func maxArea(_ height: [Int]) -> Int {
        var x = 0, i = 0, j = height.count - 1
        while i != j {
            let y = min(height[i], height[j]) * (j - i)
            x = max(x, y)
            if height[i] < height[j] {
                i += 1
            } else {
                j -= 1
            }
        }
        return x
    }
    
    func intToRoman(_ num: Int) -> String {
        if num < 1 || num > 3999 {
            return "1 <= num <= 3999"
        }
        var res = ""
        let arr = [[1000:"M"],
                   [900:"CM"], [500:"D"], [400:"CD"], [100:"C"],
                   [90:"XC"], [50:"L"], [40:"XL"], [10:"X"],
                   [9:"IX"], [5:"V"], [4:"IV"], [1:"I"]]
        var num = num
        for map in arr {
            for (k,v) in map {
                let n = num / k
                for _ in 0 ..< n {
                    res += v
                }
                num -= n * k
            }
        }
        return res
    }
    
    func intToRoman2(_ num: Int) -> String {
        if num < 1 || num > 3999 {
            return "1 <= num <= 3999"
        }
        let thousands = ["", "M", "MM", "MMM"]
        let hundreds = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
        let tens = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
        let ones = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
        return "\(thousands[num / 1000])\(hundreds[num % 1000 / 100])\(tens[num % 100 / 10])\(ones[num % 10])"
    }
    
    func romanToInt(_ s: String) -> Int {
        let romans: [Character:Int] = ["I":1, "V":5, "X":10, "L":50, "C":100, "D":500, "M":1000]
        var p: Character? = nil
        var n = 0
        for c in s {
            if let p = p,
               let i = romans[p],
               let j = romans[c] {
                if i < j {
                    n -= i
                } else {
                    n += i
                }
            }
            p = c
        }
        if let p = p, let i = romans[p] {
            n += i
        }
        return n
    }
    
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.isEmpty {
            return ""
        }
        var pre = strs.first ?? ""
        if pre.isEmpty {
            return ""
        }
        for i in 1 ..< strs.count {
            let str = strs[i]
            if str.isEmpty {
                return ""
            }
            let pa = Array(pre)
            let sa = Array(str)
            var j = 0
            while j < pa.count {
                if j < sa.count, sa[j] == pa[j] {
                    j += 1
                } else {
                    break
                }
            }
            if j > 0 {
                pre = (pre as NSString).substring(to: j)
                if pre.isEmpty {
                    return ""
                }
            } else {
                return ""
            }
        }
        return pre
    }
    
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var sums = [[Int]]()
        if nums.count < 3 {
            return sums
        }
        let nums = nums.sorted()
        for i in 0 ..< nums.count - 1 {
            if nums[i] > 0 {
                break
            }
            if i > 0, nums[i] == nums[i - 1] {
                continue
            }
            var l = i + 1
            var r = nums.count - 1
            while l < r {
                let sum = nums[i] + nums[l] + nums[r]
                if sum == 0 {
                    sums.append([nums[i], nums[l], nums[r]])
                    while l < r, nums[l] == nums[l+1] {
                        l += 1
                    }
                    while l < r, nums[r] == nums[r-1] {
                        r -= 1
                    }
                    l += 1
                    r -= 1
                } else if sum < 0 {
                    l += 1
                } else if sum > 0 {
                    r -= 1
                }
            }
        }
        return sums
    }
    
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        if nums.count < 3 {
            return 0
        }
        let nums = nums.sorted()
        var sums = Int(Int32.max)
        for i in 0 ..< nums.count - 1 {
            var l = i + 1
            var r = nums.count - 1
            while l < r {
                let sum = nums[i] + nums[l] + nums[r]
                if sum == target {
                    return sum
                }
                if abs(sums - target) > abs(sum - target) {
                    sums = sum
                }
                if sum < target {
                    while l < r, nums[l] == nums[l + 1] {
                        l += 1
                    }
                    l += 1
                } else {
                    while l < r, nums[r] == nums[r - 1] {
                        r -= 1
                    }
                    r -= 1
                }
            }
        }
        return sums
    }
    
    let letterMap: [Character:String] = [
        "2": "abc",
        "3": "def",
        "4": "ghi",
        "5": "jkl",
        "6": "mno",
        "7": "pqrs",
        "8": "tuv",
        "9": "wxyz"
    ]
    
    func letterCombinations(_ digits: String) -> [String] {
        if digits.isEmpty { return [] }
        var combinations = [String]()
        var combination = [Character]()
        letterCombinations(&combinations, Array(digits), 0, &combination)
        return combinations
    }
    
    private func letterCombinations(_ combinations: inout [String], _ digits: [Character], _ index: Int, _ combination: inout [Character]) {
        if index < digits.count {
            let digit = digits[index]
            if let letter = letterMap[digit] {
                for c in letter {
                    combination.append(c)
                    letterCombinations(&combinations, digits, index + 1, &combination)
                    combination.removeLast()
                }
            }
        } else {
            combinations.append(String(combination))
        }
    }
    
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var sums = [[Int]]()
        if nums.count < 4 {
            return sums
        }
        let nums = nums.sorted()
        for i in 0 ... nums.count - 4 {
            if i > 0, nums[i] == nums[i - 1] {
                continue
            }
            for j in i + 1 ... nums.count - 3 {
                if j > i + 1, nums[j] == nums[j - 1] {
                    continue
                }
                var l = j + 1
                var r = nums.count - 1
                while l < r {
                    let sum = nums[i] + nums[j] + nums[l] + nums[r]
                    if sum < target {
                        l += 1
                    } else if sum > target {
                        r -= 1
                    } else {
                        sums.append([nums[i], nums[j], nums[l], nums[r]])
                        while l < r, nums[l] == nums[l + 1] {
                            l += 1
                        }
                        while l < r, nums[r] == nums[r - 1] {
                            r -= 1
                        }
                        l += 1
                        r -= 1
                    }
                }
            }
        }
        return sums
    }
    
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummy = ListNode(0, head)
        var node1: ListNode? = dummy
        var node2 = head
        for _ in 0 ..< n {
            node2 = node2?.next
        }
        while node2 != nil {
            node2 = node2?.next
            node1 = node1?.next
        }
        node1?.next = node1?.next?.next
        return dummy.next
    }
    
    func isValid(_ s: String) -> Bool {
        let stack = Stack()
        for c in s {
            switch c {
            case "(", "[", "{":
                stack.push(c)
            case ")":
                if let p = stack.pop() as? Character, p == "(" {
                    continue
                } else {
                    return false
                }
            case "}":
                if let p = stack.pop() as? Character, p == "{" {
                    continue
                } else {
                    return false
                }
            case "]":
                if let p = stack.pop() as? Character, p == "[" {
                    continue
                } else {
                    return false
                }
            default:
                break
            }
        }
        return stack.count == 0
    }
    
    func mergeTwoLists_(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        guard let l1 = list1 else {
            return list2
        }
        guard let l2 = list2 else {
            return list1
        }
        if l1.val < l2.val {
            l1.next = mergeTwoLists(l1.next, l2)
            return l1
        } else {
            l2.next = mergeTwoLists(l1, l2.next)
            return l2
        }
    }
    
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        let head = ListNode()
        var tail: ListNode? = head
        var l1 = list1, l2 = list2
        while l1 != nil, l2 != nil {
            if l1!.val < l2!.val {
                tail?.next = l1
                l1 = l1?.next
            } else {
                tail?.next = l2
                l2 = l2?.next
            }
            tail = tail?.next
        }
        tail?.next = l1 == nil ? l2 : l1
        return head.next
    }
    
    func generateParenthesis(_ n: Int) -> [String] {
        var p = [String]()
        generateParenthesis(&p, "", 0, 0, n)
        return p
    }

    private func generateParenthesis(_ p: inout [String], _ s: String, _ i: Int, _ j: Int, _ n: Int) {
        if s.count == n * 2 {
            p.append(s)
            return
        }
        if i < n {
            generateParenthesis(&p, s + "(", i + 1, j, n)
        }
        if i > j {
            generateParenthesis(&p, s + ")", i, j + 1, n)
        }
    }
    
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var list = [ListNode]()
        for obj in lists {
            if let obj = obj {
                list.append(obj)
            }
        }
        if list.isEmpty {
            return nil
        }
        var first = list.first
        while list.count > 1 {
            first = mergeTwoLists(first, list.removeLast())
        }
        return first
    }
    
    func swapPairs(_ head: ListNode?) -> ListNode? {
        if let head = head, let next = head.next {
            head.next = swapPairs(next.next)
            next.next = head
            return next
        }
        return head
    }
    
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        let stack = Stack()
        var node = head
        for i in 1 ... k {
            if let node = node {
                stack.push(node)
            }
            node = node?.next
            if node == nil, i < k {
                return head
            }
        }
        let head = stack.pop() as? ListNode
        var tail: ListNode? = head
        while !stack.isEmpty {
            tail?.next = stack.pop() as? ListNode
            if let next = tail?.next {
                tail = next
            }
        }
        tail?.next = reverseKGroup(node, k)
        return head
    }
    
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.isEmpty { return 0 }
        var i = 0
        for j in 1 ..< nums.count {
            if nums[i] != nums[j]  {
                i += 1
                nums[i] = nums[j]
            }
        }
        return i + 1
    }
    
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        if nums.isEmpty {
            return 0
        }
        var i = 0
        for j in 0 ..< nums.count {
            if nums[j] != val {
                nums[i] = nums[j]
                i += 1
            }
        }
        return i
    }
    
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if haystack.isEmpty || needle.isEmpty || haystack.count < needle.count {
            return -1
        }
        let str = Array(haystack)
        let sub = Array(needle)
        var i = 0, j = 0
        while i < str.count {
            if str[i] == sub[j] {
                j += 1
            } else {
                i -= j
                j = 0
            }
            i += 1
            if j == sub.count {
                return i - j
            }
        }
        return -1
    }
    
    func strStrKMP(_ haystack: String, _ needle: String) -> Int {
        if haystack.isEmpty || needle.isEmpty || haystack.count < needle.count {
            return -1
        }
        let str = Array(haystack)
        let sub = Array(needle)
        var pi = Array(repeating: 0, count: sub.count)
        var j = 0
        for i in 1 ..< sub.count {
            while j > 0, sub[i] != sub[j] {
                j = pi[j - 1]
            }
            if sub[i] == sub[j] {
                j += 1
            }
            pi[i] = j
        }
        j = 0
        for i in 0 ..< str.count {
            while j > 0, str[i] != sub[j] {
                j = pi[j - 1]
            }
            if str[i] == sub[j] {
                j += 1
            }
            if j == sub.count {
                return i - sub.count + 1
            }
        }
        return -1
    }
    
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        if divisor == 0 { return 0 }
        //
        if dividend == Int32.min {
            if divisor == 1 {
                return Int(Int32.min)
            } else if divisor == -1 {
                return Int(Int32.max)
            }
        } else if divisor == Int32.min {
            return dividend == Int32.min ? 1 : 0
        }
        //
        var negative = false
        if dividend >= 0, divisor < 0 {
            negative = true
        } else if dividend < 0, divisor >= 0 {
            negative = true
        }
        //
        var x = dividend < 0 ? dividend : -dividend
        let y = divisor < 0 ? divisor : -divisor
        var z = 0
        while x <= y {
            var i = y, j = 1
            while i >= x - i {
                i += i
                j += j
            }
            x -= i
            z += j
        }
        //
        return negative ? -z : z
    }
}
