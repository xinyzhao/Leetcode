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
    
    func isMatchRegular(_ s: String, _ p: String) -> Bool {
        let ss = Array("." + s)
        let pp = Array("." + p)
        let m = s.count
        let n = p.count
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: n + 1), count: m + 1)
        dp[0][0] = true
        for j in 0 ... n {
            if j == 0 { continue }
            if pp[j] == "*" {
                dp[0][j] = dp[0][j-2]
            }
        }
        for i in 0 ... m {
            if i == 0 { continue }
            for j in 0 ... n {
                if j == 0 { continue }
                if pp[j] == "." || pp[j] == ss[i] {
                    dp[i][j] = dp[i - 1][j - 1]
                } else if pp[j] == "*" {
                    if pp[j - 1] == "." || pp[j - 1] == ss[i] {
                        dp[i][j] = dp[i][j - 2] || dp[i][j - 1] || dp[i - 1][j]
                    } else {
                        dp[i][j] = dp[i][j - 2]
                    }
                }
            }
        }
        return dp[m][n]
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
        let stack = Stack<Character>()
        for c in s {
            switch c {
            case "(", "[", "{":
                stack.push(c)
            case ")":
                if let p = stack.pop(), p == "(" {
                    continue
                } else {
                    return false
                }
            case "}":
                if let p = stack.pop(), p == "{" {
                    continue
                } else {
                    return false
                }
            case "]":
                if let p = stack.pop(), p == "[" {
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
        let stack = Stack<ListNode>()
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
        let head = stack.pop()
        var tail: ListNode? = head
        while !stack.isEmpty {
            tail?.next = stack.pop()
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
    
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        var ret = [Int]()
        //
        let str = s as NSString
        let wordLen = words.first!.count
        if str.length < words.count * wordLen {
            return ret
        }
        //
        var wordMap = [String:Int]()
        for word in words {
            let num = wordMap[word] ?? 0
            wordMap[word] = num + 1
        }
        //
        for i in 0 ... str.length - words.count * wordLen {
            var map = [String:Int]()
            for j in 0 ..< words.count {
                let key = str.substring(with: NSMakeRange(i + j * wordLen, wordLen))
                if let _ = wordMap[key] {
                    let num = map[key] ?? 0
                    map[key] = num + 1
                } else {
                    break
                }
            }
            var match = true
            for (k,v) in wordMap {
                guard let val = map[k], val == v else {
                    match = false
                    break
                }
            }
            if match {
                ret.append(i)
            }
        }
        //
        return ret
    }
    
    func nextPermutation(_ nums: inout [Int]) {
        var asc = true
        for i in 0 ..< nums.count - 1 {
            if nums[i] < nums[i + 1] {
                asc = false
                break
            }
        }
        if asc {
            var i = 0
            var j = nums.count - 1
            while i < j {
                nums[i] += nums[j]
                nums[j] = nums[i] - nums[j]
                nums[i] = nums[i] - nums[j]
                i += 1
                j -= 1
            }
            return
        }
        //
        var i = nums.count - 2
        var j = i + 1
        while i >= 0 {
            if nums[i] < nums[j] {
                j = nums.count - 1
                while j > i {
                    if nums[i] < nums[j] {
                        nums[i] += nums[j]
                        nums[j] = nums[i] - nums[j]
                        nums[i] = nums[i] - nums[j]
                        break
                    }
                    j -= 1
                }
                //
                i = i + 1
                j = nums.count - 1
                while i < j {
                    nums[i] += nums[j]
                    nums[j] = nums[i] - nums[j]
                    nums[i] = nums[i] - nums[j]
                    i += 1
                    j -= 1
                }
                //
                break
            }
            i -= 1
            j -= 1
        }
    }
    
    func longestValidParentheses(_ s: String) -> Int {
        let arr = Array(s)
        var len = 0, l = 0, r = 0
        for i in 0 ..< s.count {
            if arr[i] == "(" {
                l += 1
            } else {
                r += 1
            }
            if r == l {
                len = max(len, r + l)
            } else if r > l {
                l = 0
                r = 0
            }
        }
        l = 0
        r = 0
        for j in 0 ..< s.count {
            let i = s.count - j - 1
            if arr[i] == "(" {
                l += 1
            } else {
                r += 1
            }
            if r == l {
                len = max(len, r + l)
            } else if l > r {
                l = 0
                r = 0
            }
        }
        return len
    }
    
    func search(_ nums: [Int], _ target: Int) -> Int {
        var l = 0, r = nums.count - 1
        while l <= r {
            let mid = (l + r) / 2
            if nums[mid] == target {
                return mid
            }
            if nums[l] <= nums[mid] {
                if target >= nums[l], target < nums[mid] {
                    r = mid - 1
                } else {
                    l = mid + 1
                }
            } else {
                if target > nums[mid], target <= nums[r] {
                    l = mid + 1
                } else {
                    r = mid - 1
                }
            }
        }
        return -1
    }
    
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        let search: (_ nums: [Int], _ target: Int, _ left: Bool) -> Int = { nums,target,left in
            var ret = -1
            var l = 0, r = nums.count - 1, m = 0
            while l <= r {
                m = (l + r) / 2
                if target < nums[m] {
                    r = m - 1
                } else if target > nums[m] {
                    l = m + 1
                } else {
                    ret = m
                    if left {
                        r = m - 1
                    } else {
                        l = m + 1
                    }
                }
            }
            return ret
        }
        let l = search(nums, target, true)
        let r = search(nums, target, false)
        return [l, r]
    }
    
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var l = 0, r = nums.count - 1
        while l <= r {
            let mid = (l + r) / 2
            if target < nums[mid] {
                r = mid - 1
            } else if target > nums[mid] {
                l = mid + 1
            } else {
                return mid
            }
        }
        return l
    }
    
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        var lines = [Int:[Character]]()
        var columns = [Int:[Character]]()
        var blocks = [Int:[Character]]()
        for i in 0 ..< board.count {
            let row = board[i]
            for j in 0 ..< row.count {
                let c = row[j]
                if c == "." { continue }
                //
                var line = lines[i] ?? [Character]()
                if line.contains(c) {
                    return false
                }
                line.append(c)
                lines[i] = line
                //
                var column = columns[j] ?? [Character]()
                if column.contains(c) {
                    return false
                }
                column.append(c)
                columns[j] = column
                //
                let k = (i / 3) * 3 + j / 3
                var block = blocks[k] ?? [Character]()
                if block.contains(c) {
                    return false
                }
                block.append(c)
                blocks[k] = block
            }
        }
        return true
    }
    
    func solveSudoku(_ board: inout [[Character]]) {
        let grids = solveSudokuGrids(&board)
        for grid in grids {
            for c in grid.values {
                var copy = board
                copy[grid.x][grid.y] = c
                let next = solveSudokuGrids(&copy)
                if next.isEmpty, isValidSudoku(copy) {
                    board = copy
                    return
                }
            }
        }
    }
    
    func solveSudokuGrids(_ board: inout [[Character]]) -> [SudokuGrid]  {
        let temps: [Character] = ["1","2","3","4","5","6","7","8","9"]
        var lines: [[Character]] = {
            var list = [[Character]]()
            for _ in 0 ..< temps.count {
                list.append(temps)
            }
            return list
        }()
        var columns: [[Character]] = {
            var list = [[Character]]()
            for _ in 0 ..< temps.count {
                list.append(temps)
            }
            return list
        }()
        var blocks: [[Character]] = {
            var list = [[Character]]()
            for _ in 0 ..< temps.count {
                list.append(temps)
            }
            return list
        }()
        var girds = [SudokuGrid]()
        for x in 0 ..< board.count {
            let line = board[x]
            for y in 0 ..< line.count {
                let c = line[y]
                if c == "." {
                    girds.append(SudokuGrid(x: x, y: y))
                    continue
                }
                if let i = lines[x].firstIndex(of: c) {
                    lines[x].remove(at: i)
                }
                if let i = columns[y].firstIndex(of: c) {
                    columns[y].remove(at: i)
                }
                let z = (x / 3) * 3 + y / 3
                if let i = blocks[z].firstIndex(of: c) {
                    blocks[z].remove(at: i)
                }
            }
        }
        var recur = false
        for gird in girds {
            gird.merge(lines[gird.x], columns[gird.y], blocks[gird.z])
            if gird.values.count == 1 {
                board[gird.x][gird.y] = gird.values[0]
                recur = true
            }
        }
        return recur ? solveSudokuGrids(&board) : girds
    }
    
    func countAndSay(_ n: Int) -> String {
        guard n > 0 else { return "" }
        var says = ["1"]
        for _ in 1 ..< n {
            if let last = says.last {
                let arr = Array(last)
                var say = [String]()
                var i = 0
                for j in 0 ..< arr.count - 1 {
                    if arr[j] != arr[j + 1] {
                        let str = "\(j - i + 1)\(arr[i])"
                        say.append(str)
                        i = j + 1
                    }
                }
                if i < arr.count {
                    let str = "\(arr.count - i)\(arr[i])"
                    say.append(str)
                }
                says.append(say.joined())
            }
        }
        return says.last ?? ""
    }
    
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var combinations = [[Int]]()
        var combination = [Int]()
        combinationSumDFS(candidates.sorted(), target, 0, &combination, &combinations)
        return combinations
    }
    
    func combinationSumDFS(_ candidates: [Int], _ target: Int, _ index: Int, _ combination: inout [Int], _ combinations: inout [[Int]]) {
        for i in index ..< candidates.count {
            let candidate = candidates[i]
            if target < candidate {
                return
            }
            combination.append(candidate)
            if target == candidate {
                combinations.append(combination)
            } else {
                combinationSumDFS(candidates, target - candidate, i, &combination, &combinations)
            }
            combination.removeLast()
        }
    }
    
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var combinations = [[Int]]()
        var combination = [Int]()
        combinationSumDFS2(candidates.sorted(), target, 0, &combination, &combinations)
        return combinations
    }
    
    func combinationSumDFS2(_ candidates: [Int], _ target: Int, _ index: Int, _ combination: inout [Int], _ combinations: inout [[Int]]) {
        for i in index ..< candidates.count {
            let candidate = candidates[i]
            if target < candidate {
                break
            }
            if i > index, candidates[i] == candidates[i - 1] {
                continue
            }
            combination.append(candidate)
            if target == candidate {
                combinations.append(combination)
            } else {
                combinationSumDFS2(candidates, target - candidate, i + 1, &combination, &combinations)
            }
            combination.removeLast()
        }
    }
    
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var nums = nums
        var i = 0, j = 0, k = 0
        while i < nums.count {
            j = nums[i] - 1
            k = nums[i]
            if k > 0, k <= nums.count, nums[i] != nums[j] {
                nums[i] = nums[j]
                nums[j] = k
            } else {
                i += 1
            }
        }
        for i in 0 ..< nums.count {
            if nums[i] != i + 1 {
                return i + 1
            }
        }
        return nums.count + 1
    }
    
    func trap(_ height: [Int]) -> Int {
        var ans = 0
        var left = 0, leftMax = 0
        var right = height.count - 1, rightMax = 0
        while left < right {
            if height[left] < height[right] {
                if leftMax < height[left] {
                    leftMax = height[left]
                } else {
                    ans += leftMax - height[left]
                }
                left += 1
            } else {
                if rightMax < height[right] {
                    rightMax = height[right]
                } else {
                    ans += rightMax - height[right]
                }
                right -= 1
            }
        }
        return ans
    }
    
    func multiply(_ num1: String, _ num2: String) -> String {
        let arr1 = Array(num1)
        let arr2 = Array(num2)
        var i = arr1.count - 1
        var j = arr2.count - 1
        var m = 0, n = 0, x = 0, y = 0, mul = 0, sum = 0
        var res = Array<Int>(repeating: 0, count: arr1.count + arr2.count)
        while i >= 0 {
            x = arr1[i].wholeNumberValue ?? 0
            while j >= 0 {
                y = arr2[j].wholeNumberValue ?? 0
                mul = x * y
                m = i + j
                n = i + j + 1
                sum = mul + res[n]
                res[n] = sum % 10
                res[m] = res[m] + sum / 10
                j -= 1
            }
            i -= 1
            j = arr2.count - 1
        }
        var str = ""
        for n in res {
            if n > 0 || !str.isEmpty {
                str += "\(n)"
            }
        }
        return str.isEmpty ? "0" : str
    }
    
    func isMatchWildcard(_ s: String, _ p: String) -> Bool {
        let ss = Array(s)
        let pp = Array(p)
        let m = s.count
        let n = p.count
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: n + 1), count: m + 1)
        dp[0][0] = true
        for j in 0 ... n {
            if j == 0 { continue }
            if pp[j - 1] == "*" {
                dp[0][j] = true
            } else {
                break
            }
        }
        for i in 0 ... m {
            if i == 0 { continue }
            for j in 0 ... n {
                if j == 0 { continue }
                if pp[j - 1] == "*" {
                    dp[i][j] = dp[i][j - 1] || dp[i - 1][j]
                } else if pp[j - 1] == "?" || ss[i - 1] == pp[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1]
                }
            }
        }
        return dp[m][n]
    }
    
    func jump(_ nums: [Int]) -> Int {
        var steps = 0
        var i = 0, l = 0, r = 0
        while i < nums.count - 1 {
            steps += 1
            l = i + 1
            r = i + nums[i]
            if r >= nums.count - 1 {
                break
            }
            while l < r, r < nums.count {
                if l + nums[l] < r + nums[r] {
                    l += 1
                } else {
                    r -= 1
                }
            }
            i = l
        }
        return steps
    }
    
    func permute(_ nums: [Int]) -> [[Int]] {
        var ret = [[Int]]()
        if nums.count > 0 {
            var path = [Int]()
            var used = [Bool](repeating: false, count: nums.count)
            permuteDFS(nums, 0, &path, &used, &ret)
        }
        return ret
    }
    
    func permuteDFS(_ nums: [Int], _ index: Int, _ path: inout [Int], _ used: inout [Bool], _ ret: inout [[Int]]) {
        if index == nums.count {
            ret.append(path)
            return
        }
        for i in 0 ..< nums.count {
            if used[i] { continue }
            path.append(nums[i])
            used[i] = true
            permuteDFS(nums, index + 1, &path, &used, &ret)
            used[i] = false
            path.removeLast()
        }
    }
    
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var ret = [[Int]]()
        if nums.count > 0 {
            var path = [Int]()
            var used = [Bool](repeating: false, count: nums.count)
            permuteUniqueDFS(nums.sorted(), 0, &path, &used, &ret)
        }
        return ret
    }
    
    func permuteUniqueDFS(_ nums: [Int], _ index: Int, _ path: inout [Int], _ used: inout [Bool], _ ret: inout [[Int]]) {
        if index == nums.count {
            ret.append(path)
            return
        }
        for i in 0 ..< nums.count {
            if used[i] { continue }
            if i > 0, nums[i] == nums[i - 1], !used[i - 1] { continue }
            path.append(nums[i])
            used[i] = true
            permuteUniqueDFS(nums, index + 1, &path, &used, &ret)
            used[i] = false
            path.removeLast()
        }
    }
    
    func rotate(_ matrix: inout [[Int]]) {
        let m = matrix.count / 2
        let n = (matrix.count + 1) / 2
        for i in 0 ..< m {
            var i1 = i
            for j in 0 ..< n {
                var j1 = j
                var k1 = matrix[i1][j1]
                repeat {
                    (i1,j1,k1) = rotateCW(&matrix, i1, j1, k1)
                } while i1 != i || j1 != j
            }
        }
    }
    
    func rotateCW(_ matrix: inout [[Int]], _ i: Int, _ j: Int, _ k: Int) -> (Int, Int, Int) {
        // CW[i1,j1] = [j, n - i - 1], n = matrix.count
        let n = matrix.count
        let i1 = j
        let j1 = n - i - 1
        let k1 = matrix[i1][j1]
        matrix[i1][j1] = k
        return (i1, j1, k1)
    }
    
    func rotateCCW(_ matrix: inout [[Int]], _ i: Int, _ j: Int, _ k: Int) -> (Int, Int, Int) {
        // CCW[i1,j1] = [n - j - 1, i], n = matrix.count
        let n = matrix.count
        let i1 = n - j - 1
        let j1 = i
        let k1 = matrix[i1][j1]
        matrix[i1][j1] = k
        return (i1, j1, k1)
    }
    
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var map = [String:[String]]()
        for str in strs {
            let key = String(str.sorted())
            if let _ = map[key] {
                map[key]!.append(str)
            } else {
                map[key] = [str]
            }
        }
        return Array(map.values)
    }
    
    func myPow(_ x: Double, _ n: Int) -> Double {
        if x == 0.0 { return 0.0 }
        var res = Double(1)
        var x = x, n = n
        if n < 0 {
            x = 1 / x
            n = -n
        }
        while n > 0 {
            if n & 1 == 1 { // n % 2 == 1
                res *= x
            }
            x *= x // n ^ 2
            n >>= 1 // n /= 2
        }
        return res
    }
    
    func solveNQueens(_ n: Int) -> [[String]] {
        if n == 1 { return [["Q"]] }
        var board = [[String]]()
        var path = [Int:Int]()
        var columns = Set<Int>()
        var leftDiagonals = Set<Int>()
        var rightDiagonals = Set<Int>()
        solveNQueensDFS(&board, &path, n, 0, &columns, &leftDiagonals, &rightDiagonals)
        return board
    }
    
    func solveNQueensDFS(_ board: inout [[String]], _ path: inout [Int:Int], _ n: Int, _ row: Int, _ columns: inout Set<Int>, _ leftDiagonals: inout Set<Int>, _ rightDiagonals: inout Set<Int>) -> Void {
        if row == n {
            var arr = [String](repeating: "", count: n)
            for (i,j) in path {
                var str = [String](repeating: ".", count: n)
                str[j] = "Q"
                arr[i] = str.joined()
            }
            board.append(arr)
            return
        }
        for j in 0 ..< n {
            if !columns.contains(j),
               !leftDiagonals.contains(row + j),
               !rightDiagonals.contains(row - j) {
                path[row] = j
                columns.insert(j)
                leftDiagonals.insert(row + j)
                rightDiagonals.insert(row - j)
                solveNQueensDFS(&board, &path, n, row + 1, &columns, &leftDiagonals, &rightDiagonals)
                path.removeValue(forKey: row)
                columns.remove(j)
                leftDiagonals.remove(row + j)
                rightDiagonals.remove(row - j)
            }
        }
    }
    
    func totalNQueens(_ n: Int) -> Int {
        return solveNQueens(n).count
    }
    
    func maxSubArray_0(_ nums: [Int]) -> Int {
        var sums = Int.min, sum = 0
        for i in 0 ..< nums.count {
            for j in i ..< nums.count {
                sum += nums[j]
                if sums < sum  {
                    sums = sum
                }
            }
            sum = 0
        }
        return sums
    }
    
    func maxSubArray_1(_ nums: [Int]) -> Int {
        var max = Int.min, sum = 0
        for i in 0 ..< nums.count {
            sum += nums[i]
            if max < sum {
                max = sum
            }
            if sum < 0 {
                sum = 0
            }
        }
        return max
    }
    
    func maxSubArray(_ nums: [Int]) -> Int {
        var max = Int.min, sum = 0, dp = [Int](repeating: 0, count: nums.count)
        for i in 0 ..< nums.count {
            if i == 0 {
                dp[i] = nums[i]
            } else {
                sum = dp[i - 1] + nums[i]
                dp[i] = sum > nums[i] ? sum : nums[i]
            }
            if max < dp[i] { max = dp[i] }
        }
        return max
    }
    
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var ret = [Int]()
        var left = 0, right = (matrix.first?.count ?? 1) - 1
        var top = 0, bottom = matrix.count - 1
        var x = 0, y = 0
        while true {
            // x = left -> right, y = top
            for j in left ... right {
                print("{\(ret.count): \(top),\(j)}")
                ret.append(matrix[top][j])
            }
            top += 1
            if top > bottom { break }
            // x = right, y = top -> bottom
            for i in top ... bottom {
                print("{\(ret.count): \(i),\(right)}")
                ret.append(matrix[i][right])
            }
            right -= 1
            if right < left { break }
            // x = right -> left, y = bottom
            x = right
            while x >= left {
                print("{\(ret.count): \(bottom),\(x)}")
                ret.append(matrix[bottom][x])
                x -= 1
            }
            bottom -= 1
            if bottom < top { break }
            // x = left, y = bottom -> top
            y = bottom
            while y >= top {
                print("{\(ret.count): \(y),\(left)}")
                ret.append(matrix[y][left])
                y -= 1
            }
            left += 1
            if left > right { break }
        }
        return ret
    }
    
    func canJump(_ nums: [Int]) -> Bool {
        var dp = 0
        for i in 0 ..< nums.count {
            if i > dp { return false }
            dp = max(dp, i + nums[i])
        }
        return true
    }
    
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        if intervals.count < 2 { return intervals}
        let list = mergeSort(intervals)
        var merged = [[Int]]()
        for i in 0 ..< list.count {
            let l = list[i][0]
            let r = list[i][1]
            let last = merged.last ?? [0,0]
            if merged.isEmpty || last[1] < l {
                merged.append([l, r])
            } else {
                merged.removeLast()
                merged.append([last[0], max(last[1], r)])
            }
        }
        return merged
    }
    
    func mergeSort(_ list: [[Int]]) -> [[Int]] {
        var list = list
        for _ in 0 ..< list.count - 1 {
            for i in 0 ..< list.count - 1 {
                if (list[i][0] > list[i + 1][0]) ||
                    (list[i][0] == list[i + 1][0] && list[i][1] > list[i + 1][1]) {
                    let p = list[i]
                    list[i] = list[i + 1]
                    list[i + 1] = p
                }
            }
        }
        return list
    }
    
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        if intervals.isEmpty { return [newInterval] }
        var new = [[Int]]()
        let s = intervals
        var t = newInterval
        for i in 0 ..< s.count {
            if s[i][0] > t[1] {
                new.append(t)
                for j in i ..< s.count {
                    new.append(s[j])
                }
                break
            }
            if s[i][1] < t[0] {
                new.append(s[i])
            } else {
                t[0] = min(t[0], s[i][0])
                t[1] = max(t[1], s[i][1])
            }
            if i == s.count - 1 {
                new.append(t)
            }
        }
        return new
    }
    
    func lengthOfLastWord(_ s: String) -> Int {
        let arr = Array(s)
        var len = 0
        let space = Character(" ")
        for i in 0 ..< arr.count {
            let c = arr[arr.count - i - 1]
            if c == space {
                if len != 0 {
                    break
                }
            } else {
                len += 1
            }
        }
        return len
    }
    
    func generateMatrix(_ n: Int) -> [[Int]] {
        var matrix = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        var l = 0, t = 0, r = n - 1, b = n - 1
        var m = 1
        while true {
            for j in l ... r {
                matrix[t][j] = m
                m += 1
            }
            t += 1
            if t > b { break }
            for i in t ... b {
                matrix[i][r] = m
                m += 1
            }
            r -= 1
            if l > r { break }
            for j in l ... r {
                matrix[b][l + r - j] = m
                m += 1
            }
            b -= 1
            if t > b { break }
            for i in t ... b {
                matrix[t + b - i][l] = m
                m += 1
            }
            l += 1
            if l > r { break }
        }
        return matrix
    }
    
    func getPermutation(_ n: Int, _ k: Int) -> String {
        var nums = [Int](repeating: 0, count: n)
        var facs = [Int](repeating: 0, count: n)
        for i in 0 ..< n {
            if i == 0 {
                facs[i] = 1
            } else {
                facs[i] = i * facs[i - 1]
            }
            nums[i] = i + 1
        }
        var k = k - 1
        var ret = ""
        for i in 1 ... n {
            let fac = facs[n - i]
            let idx = k / fac
            ret.append("\(nums[idx])")
            for j in idx ..< n - i {
                nums[j] = nums[j + 1]
            }
            k %= fac
        }
        return ret
    }
    
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        var len = 0
        var head = head, list = head, tail = head
        while list != nil {
            len += 1
            tail = list
            list = list?.next
        }
        tail?.next = head
        if len > 0 {
            let k = k % len
            for i in 0 ..< len - k {
                if i == len - k - 1 {
                    tail = head
                }
                head = head?.next
            }
            tail?.next = nil
        }
        return head
    }
    
    func uniquePathsDP(_ m: Int, _ n: Int) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0 ..< m {
            dp[i][0] = 1
        }
        for j in 0 ..< n {
            dp[0][j] = 1
        }
        for i in 1 ..< m {
            for j in 1 ..< n {
                dp[i][j] = dp[i - 1][j] + dp[i][j - 1]
            }
        }
        return dp[m - 1][n - 1]
    }
    
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var num = 1
        var x = n, y = 1
        while y < m {
            num = num * x / y
            x += 1
            y += 1
        }
        return num
    }
    
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        if obstacleGrid[0][0] == 1 { return 0 }
        let m = obstacleGrid.count
        let n = obstacleGrid[0].count
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
        for i in 0 ..< m {
            if obstacleGrid[i][0] == 0 {
                dp[i][0] = 1
            } else {
                break
            }
        }
        for j in 0 ..< n {
            if obstacleGrid[0][j] == 0 {
                dp[0][j] = 1
            } else {
                break
            }
        }
        for i in 1 ..< m {
            for j in 1 ..< n {
                if obstacleGrid[i][j] == 0 {
                    dp[i][j] = dp[i - 1][j] + dp[i][j - 1]
                } else {
                    dp[i][j] = 0
                }
            }
        }
        return dp[m - 1][n - 1]
    }
    
    func minPathSum(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        var dp = grid
        for i in 0 ..< m {
            for j in 0 ..< n {
                if i == 0, j == 0 {
                    continue
                } else if i == 0 {
                    dp[i][j] = dp[i][j - 1] + dp[i][j]
                } else if j == 0 {
                    dp[i][j] = dp[i - 1][j] + dp[i][j]
                } else {
                    dp[i][j] = min(dp[i - 1][j], dp[i][j - 1]) + dp[i][j]
                }
            }
        }
        return dp[m - 1][n - 1]
    }
    
    func isNumber(_ s: String) -> Bool {
        var state = 0
        let finals = [0,0,0,1,0,1,1,0,1]
        let transfer = [[ 0, 1, 6, 2,-1,-1],
                        [-1,-1, 6, 2,-1,-1],
                        [-1,-1, 3,-1,-1,-1],
                        [ 8,-1, 3,-1, 4,-1],
                        [-1, 7, 5,-1,-1,-1],
                        [ 8,-1, 5,-1,-1,-1],
                        [ 8,-1, 6, 3, 4,-1],
                        [-1,-1, 5,-1,-1,-1],
                        [ 8,-1,-1,-1,-1,-1]]
        for c in s {
            var status = 0
            switch c {
            case " ":
                status = 0
            case "+", "-":
                status = 1
            case ".":
                status = 3
            case "e", "E":
                status = 4
            default:
                if c.isASCII && c.asciiValue! >= 48 && c.asciiValue! <= 57 {
                    status = 2
                } else {
                    status = 5
                }
            }
            state = transfer[state][status]
            if state < 0 { return false }
        }
        return finals[state] > 0
    }
    
    func plusOne(_ digits: [Int]) -> [Int] {
        var digits = digits
        let n = digits.count
        if n == 0 { return [1] }
        plusOneMax(&digits, n - 1)
        return digits
    }
    
    func plusOneMax(_ digits: inout [Int], _ right: Int) {
        let r = right
        let l = r - 1
        if digits[r] == 9 {
            digits[r] = 0
            if l >= 0 {
                plusOneMax(&digits, right - 1)
            } else {
                digits.insert(1, at: 0)
            }
        } else {
            digits[r] = digits[r] + 1
        }
    }
    
    func addBinary(_ a: String, _ b: String) -> String {
        let len = max(a.count, b.count)
        var sum = [Character](repeating: "0", count: len)
        let a = Array(a), b = Array(b)
        var carry = 0
        for i in 0 ..< len {
            if i < a.count, a[a.count - i - 1] == "1" {
                carry += 1
            }
            if i < b.count, b[b.count - i - 1] == "1" {
                carry += 1
            }
            sum[len - i - 1] = ((carry % 2) == 0) ? "0" : "1"
            carry /= 2
        }
        if carry > 0 {
            sum.insert("1", at: 0)
        }
        return String(sum)
    }
    
    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
        var lines = [[String]](), lens = [Int]()
        var line = [String](), len = 0
        for word in words {
            if word.count <= maxWidth - len - line.count {
                line.append(word)
                len += word.count
            } else {
                lines.append(line)
                lens.append(len)
                //
                line.removeAll()
                line.append(word)
                len = word.count
            }
        }
        if line.count > 0 {
            lines.append(line)
            lens.append(len)
        }
        var strs = [String]()
        for i in 0 ..< lines.count {
            let line = lines[i]
            len = maxWidth - lens[i] - (line.count - 1)
            var str = ""
            if i == lines.count - 1 {
                // 当前行是最后一行：单词左对齐，且单词之间应只有一个空格，在行末填充剩余空格；
                str = line.joined(separator: " ")
                for _ in 0 ..< len {
                    str += " "
                }
            } else if line.count == 1 {
                // 当前行不是最后一行，且只有一个单词：该单词左对齐，在行末填充空格；
                str = line[0]
                for _ in 0 ..< len {
                    str += " "
                }
            } else {
                // 当前行不是最后一行，且不只一个单词
                let spaceNum = maxWidth - lens[i]
                let spaceAvg = spaceNum / (line.count - 1)
                let spaceExt = spaceNum % (line.count - 1)
                for j in 0 ..< line.count {
                    str += line[j]
                    if j < line.count - 1 {
                        len = spaceAvg + (j < spaceExt ? 1 : 0)
                        for _ in 0 ..< len {
                            str += " "
                        }
                    }
                }
            }
            strs.append(str)
        }
        return strs
    }
    
    func mySqrt(_ x: Int) -> Int {
        if x <= 1 { return x }
        var l = 1, r = x / 2, mid = 1, ret = 0
        while l <= r {
            mid = l + (r - l) / 2
            if mid * mid <= x {
                ret = mid
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
        return ret
    }
    
    func climbStairs(_ n: Int) -> Int {
        if n == 0 { return 1 }
        // f(x) = f(x - 1) + f(x - 2)
        var p = 0, q = 0, r = 1
        for _ in 0 ..< n {
            p = q
            q = r
            r = p + q
        }
        return r
    }
    
    func climbStairsDP(_ n: Int) -> Int {
        if n == 0 { return 1 }
        // f(x) = f(x - 1) + f(x - 2)
        var dp = [Int](repeating: 0, count: n + 1)
        for i in 0 ... n {
            if i < 2 {
                dp[i] =  1
            } else {
                dp[i] = dp[i - 1] + dp[i - 2]
            }
        }
        return dp[n]
    }
    
    func simplifyPath(_ path: String) -> String {
        let stack = Stack<String>()
        let array = (path as NSString).components(separatedBy: "/")
        for str in array {
            if str == ".." {
                let _ = stack.pop()
            } else if !str.isEmpty, str != "." {
                stack.push(str)
            }
        }
        let list = stack.sequence()
        let str = "/\(list.joined(separator: "/"))"
        return str
    }
    
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let w1 = Array(word1)
        let w2 = Array(word2)
        let m = w1.count
        let n = w2.count
        
        // 有一个字符串为空串
        if m * n == 0 {
            return m + n
        }
        
        // DP 数组
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
        
        // 边界状态初始化
        for i in 0 ..< m + 1 {
            dp[i][0] = i
        }
        for j in 0 ..< n + 1 {
            dp[0][j] = j
        }
        
        // 计算所有 DP 值
        for i in 1 ..< m + 1 {
            for j in 1 ..< n + 1 {
                let left = dp[i - 1][j] + 1
                let down = dp[i][j - 1] + 1
                var left_down = dp[i - 1][j - 1]
                if w1[i - 1] != w2[j - 1] {
                    left_down += 1
                }
                dp[i][j] = min(left, min(down, left_down))
            }
        }
        return dp[m][n]
    }
    
    func setZeroes(_ matrix: inout [[Int]]) {
        let m = matrix.count
        let n = matrix[0].count
        var i0 = false, j0 = false
        for i in 0 ..< m {
            if matrix[i][0] == 0 {
                i0 = true
                break
            }
        }
        for j in 0 ..< n {
            if matrix[0][j] == 0 {
                j0 = true
                break
            }
        }
        for i in 0 ..< m {
            if i == 0 { continue }
            for j in 0 ..< n {
                if j == 0 { continue }
                if matrix[i][j] == 0 {
                    matrix[i][0] = 0
                    matrix[0][j] = 0
                }
            }
        }
        for i in 0 ..< m {
            if i == 0 { continue }
            for j in 0 ..< n {
                if j == 0 { continue }
                if matrix[i][0] == 0 || matrix[0][j] == 0 {
                    matrix[i][j] = 0
                }
            }
        }
        if i0 {
            for i in 0 ..< m {
                matrix[i][0] = 0
            }
        }
        if j0 {
            for j in 0 ..< n {
                matrix[0][j] = 0
            }
        }
    }
    
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let m = matrix.count
        let n = matrix[0].count
        var t = 0, b = m - 1
        while t <= b {
            let i = t + (b - t) / 2
            if target == matrix[i][0] {
                return true
            } else if target < matrix[i][0] {
                b = i - 1
            } else if target > matrix[i][0] {
                if target == matrix[i][n - 1] {
                    return true
                } else if target > matrix[i][n - 1] {
                    t = i + 1
                } else {
                    var l = 1, r = n - 2
                    while l <= r {
                        let j = l + (r - l) / 2
                        if target == matrix[i][j] {
                            return true
                        } else if target > matrix[i][j] {
                            l = j + 1
                        } else {
                            r = j - 1
                        }
                    }
                    break
                }
            }
        }
        return false
    }
    
    func sortColors(_ nums: inout [Int]) {
        var i = 0, p0 = 0, p2 = nums.count - 1
        while i <= p2 {
            if nums[i] == 0 {
                if i != p0 {
                    let k = nums[i]
                    nums[i] = nums[p0]
                    nums[p0] = k
                }
                p0 += 1
                i += 1
            } else if nums[i] == 2 {
                let k = nums[i]
                nums[i] = nums[p2]
                nums[p2] = k
                p2 -= 1
            } else {
                i += 1
            }
        }
    }
    
    func minWindow(_ s: String, _ t: String) -> String {
        let s = Array(s), t = Array(t)
        var l = 0, r = s.count
        var i = 0, j = 0
        var smap = [Character:Int]()
        var tmap = [Character:Int]()
        for c in t {
            tmap[c] = (tmap[c] ?? 0) + 1
        }
        while j < s.count {
            let c = s[j]
            if let _ = tmap[c] {
                smap[c] = (smap[c] ?? 0) + 1
            }
            while i <= j {
                if minWindowContains(smap, tmap) {
                    let c = s[i]
                    if let _ = tmap[c] {
                        smap[c] = (smap[c] ?? 0) - 1
                    }
                    if r - l > j - i {
                        l = i
                        r = j
                    }
                    i += 1
                } else {
                    break
                }
            }
            j += 1
        }
        if l >= 0, r < s.count {
            return String(s[l ... r])
        } else {
            return ""
        }
    }
    
    func minWindowContains(_ s: [Character:Int], _ t: [Character:Int]) -> Bool {
        if s.count != t.count {
            return false
        }
        for (k,v) in s {
            if let tv = t[k] {
                if v < tv {
                    return false
                }
            } else {
                return false
            }
        }
        return true
    }
    
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var list = [[Int]]()
        if k > 0, k <= n {
            var path = [Int]()
            combineDFS(&list, &path, 1, n, k)
        }
        return list
    }
    
    func combineDFS(_ list: inout [[Int]], _ path: inout [Int], _ i: Int, _ n: Int, _ k: Int) {
        if path.count == k {
            list.append(path)
            return
        }
        if i > n { return }
        for j in i ... n {
            path.append(j)
            combineDFS(&list, &path, j + 1, n, k)
            path.removeLast()
        }
    }
    
    func subsets(_ nums: [Int]) -> [[Int]] {
        var sets: [[Int]] = [[]]
        var path = [Int]()
        subsetsDFS(&sets, &path, nums, 0)
        return sets
    }
    
    func subsetsDFS(_ sets: inout [[Int]], _ path: inout [Int], _ nums: [Int], _ i: Int) {
        if i == nums.count {
            return
        }
        for j in i ..< nums.count {
            path.append(nums[j])
            sets.append(path)
            subsetsDFS(&sets, &path, nums, j + 1)
            path.removeLast()
        }
    }
    
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let m = board.count
        let n = board[0].count
        let list = Array(word)
        var path = [String:Character]()
        for i in 0 ..< m {
            for j in 0 ..< n {
                if board[i][j] == list[0] {
                    if existBacktrack(board, i, j, list, &path) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func existBacktrack(_ board: [[Character]], _ i: Int, _ j: Int, _ word: [Character], _ path: inout [String:Character]) -> Bool {
        print("{\(i),\(j)} \'\(word[path.count])\' [\(path.count)]")
        let key = "\(i)_\(j)"
        if path[key] == nil {
            path[key] = board[i][j]
            if path.count == word.count { return true }
            let m = board.count
            let n = board[0].count
            let k = path.count
            if i > 0, board[i - 1][j] == word[k] {
                if existBacktrack(board, i - 1, j, word, &path) {
                    return true
                }
            }
            if i < m - 1, board[i + 1][j] == word[k] {
                if existBacktrack(board, i + 1, j, word, &path) {
                    return true
                }
            }
            if j > 0, board[i][j - 1] == word[k] {
                if existBacktrack(board, i, j - 1, word, &path) {
                    return true
                }
            }
            if j < n - 1, board[i][j + 1] == word[k] {
                if existBacktrack(board, i, j + 1, word, &path) {
                    return true
                }
            }
            path.removeValue(forKey: key)
        }
        return false
    }
    
    func removeDuplicates2(_ nums: inout [Int]) -> Int {
        var len = nums.count
        if len <= 2 { return len }
        var i = 1, num = 1
        while i < len {
            if nums[i] == nums[i - 1] {
                num += 1
                if num > 2 {
                    for j in i ..< len - 1 {
                        nums[j] = nums[j + 1]
                    }
                    len -= 1
                    num -= 1
                } else {
                    i += 1
                }
            } else {
                num = 1
                i += 1
            }
        }
        return len
    }
    
    func search2(_ nums: [Int], _ target: Int) -> Bool {
        if nums.isEmpty { return false }
        if nums.count == 1 { return nums[0] == target }
        var l = 0, r = nums.count - 1
        while l <= r {
            let mid = l + (r - l) / 2
            if nums[mid] == target {
                return true
            }
            if nums[l] == nums[mid], nums[mid] == nums[r] {
                l += 1
                r -= 1
                continue
            } else if nums[l] <= nums[mid] {
                if nums[l] <= target, target < nums[mid] {
                    r = mid - 1
                } else {
                    l = mid + 1
                }
            } else {
                if nums[mid] < target, target <= nums[r] {
                    l = mid + 1
                } else {
                    r = mid - 1
                }
            }
        }
        return false
    }
    
    func deleteDuplicates2(_ head: ListNode?) -> ListNode? {
        let dummy = ListNode(0, head)
        var node: ListNode? = dummy
        while node?.next != nil, node?.next?.next !=  nil {
            if node?.next?.val == node?.next?.next?.val {
                let val = node?.next?.val
                while node?.next != nil, node?.next?.val == val {
                    node?.next = node?.next?.next
                }
            } else {
                node = node?.next
            }
        }
        return dummy.next
    }
    
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var node = head
        while node !=  nil, node?.next != nil {
            if node?.val == node?.next?.val {
                node?.next = node?.next?.next
            } else {
                node = node?.next
            }
        }
        return head
    }
    
    func largestRectangleArea(_ heights: [Int]) -> Int {
        var area = 0
        var heights = heights
        heights.insert(0, at: 0)
        heights.append(0)
        let stack = Stack<Int>()
        for i in 0 ..< heights.count {
            while !stack.isEmpty, let j = stack.peek(), heights[j] >= heights[i] {
                let x = stack.pop() ?? 0
                let l = (stack.peek() ?? 0) + 1
                let r = i - 1
                area = max(area, (r - l + 1) * heights[x])
            }
            stack.push(i)
        }
        return area
    }
    
    func maximalRectangle(_ matrix: [[Character]]) -> Int {
        let m = matrix.count, n = matrix[0].count
        var heights = [Int](repeating: 0, count: n)
        var area = 0
        for i in 0 ..< m {
            for j in 0 ..< n {
                if matrix[i][j] == "1" {
                    heights[j] += 1
                } else {
                    heights[j] = 0
                }
            }
            area = max(area, largestRectangleArea(heights))
        }
        return area
    }
    
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        var h0 = ListNode(0), h1: ListNode? = h0
        var t0 = ListNode(0), t1: ListNode? = t0
        var node = head
        while node != nil {
            if node!.val < x {
                h1?.next = node
                h1 = h1?.next
            } else {
                t1?.next = node
                t1 = t1?.next
            }
            node = node?.next
        }
        h1?.next = t0.next
        t1?.next = nil
        return h0.next
    }
    
    func isScramble(_ s1: String, _ s2: String) -> Bool {
        if s1 == s2 { return true }
        if s1.count != s2.count { return false }
        let n = s1.count
        let cs1 = Array(s1), cs2 = Array(s2)
        var f = [[[Bool]]](repeating: [[Bool]](repeating: [Bool](repeating: false, count: n + 1), count: n), count: n)
        for i in 0 ..< n {
            for j in 0 ..< n {
                f[i][j][1] = cs1[i] == cs2[j]
            }
        }
        for len in 0 ... n {
            if len < 2 { continue }
            for i in 0 ... n - len {
                for j in 0 ... n - len {
                    for k in 1 ..< len {
                        let a = f[i][j][k] && f[i + k][j + k][len - k]
                        let b = f[i][j + len - k][k] && f[i + k][j][len - k]
                        if a || b {
                            f[i][j][len] = true
                        }
                    }
                }
            }
        }
        return f[0][0][n]
    }
    
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        if n == 0 { return }
        let nums = nums1
        var i = 0, j = 0, k = 0
        while i < m, j < n {
            if nums[i] < nums2[j] {
                nums1[k] = nums[i]
                i += 1
            } else {
                nums1[k] = nums2[j]
                j += 1
            }
            k += 1
        }
        while i < m {
            nums1[k] = nums[i]
            i += 1
            k += 1
        }
        while j < n {
            nums1[k] = nums2[j]
            j += 1
            k += 1
        }
    }
    
    func grayCode(_ n: Int) -> [Int] {
        var ret = [Int]()
        for i in 0 ..< (1 << n) {
            ret.append((i >> 1) ^ i)
        }
        return ret
    }
    
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var sets = [[Int]]()
        var path = [Int]()
        subsetsWithDupBacktrack(nums.sorted(), 0, &path, &sets)
        return sets
    }

    func subsetsWithDupBacktrack(_ nums: [Int], _ index: Int, _ path: inout [Int], _ sets: inout [[Int]]) {
        sets.append(path)
        for i in index ..< nums.count {
            if (i > index && nums[i] == nums[i - 1]) {
                continue;
            }
            path.append(nums[i])
            subsetsWithDupBacktrack(nums, i + 1, &path, &sets)
            path.removeLast()
        }
    }
    
    func numDecodings(_ s: String) -> Int {
        let sArr = Array(s)
        let n = sArr.count
        var dp = [Int](repeating: 0, count: n + 1)
        let zero = Character("0").asciiValue!
        for i in 0 ... n {
            if i == 0 {
                dp[i] = 1
                continue
            }
            if sArr[i - 1] != "0" {
                dp[i] += dp[i - 1]
            }
            if i > 1 {
                let a = sArr[i - 2].asciiValue ?? zero
                let b = sArr[i - 1].asciiValue ?? zero
                if a != zero, (a - zero) * 10 + (b - zero) <= 26 {
                    dp[i] += dp[i - 2]
                }
            }
        }
        return dp[n]
    }
    
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        if head == nil || head?.next == nil || left == right { return head }
        let dummy = ListNode(0, head)
        var prev: ListNode? = dummy
        for _ in 0 ..< left - 1 {
            prev = prev?.next
        }
        var node = prev?.next, next: ListNode? = nil
        for _ in left ..< right {
            next = node?.next
            node?.next = next?.next
            next?.next = prev?.next
            prev?.next = next
        }
        return dummy.next
    }
    
    func restoreIpAddresses(_ s: String) -> [String] {
        let sArr = Array(s)
        var sets = [String]()
        var path = [String]()
        restoreIpAddresses(sArr, 0, &path, &sets)
        return sets
    }
    
    func restoreIpAddresses(_ s: [Character], _ index: Int, _ path: inout [String], _ sets: inout [String]) {
        if index >= s.count {
            if path.count == 4 {
                sets.append(path.joined(separator: "."))
            }
            return
        }
        var part = ""
        var sums = 0
        for i in index ..< min(index + 3, s.count) {
            if sums * 10 + Int(s[i].asciiValue! - Character("0").asciiValue!) > 255 {
                break
            } else {
                sums *= 10
                sums += Int(s[i].asciiValue! - Character("0").asciiValue!)
            }
            part.append(s[i])
            path.append(part)
            restoreIpAddresses(s, i + 1, &path, &sets)
            path.removeLast()
            if part.count == 1, s[i] == "0" {
                break
            }
        }
    }
    
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var values = [Int]()
        root?.preorderRecursive(&values)
        return values
    }
    
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var values = [Int]()
        root?.inorderRecursive(&values)
        return values
    }
    
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var values = [Int]()
        root?.postorderRecursive(&values)
        return values
    }
    
    func generateTrees(_ n: Int) -> [TreeNode?] {
        if n == 0 {
            return []
        }
        return generateTrees(1, n)
    }
    
    func generateTrees(_ start: Int, _ end: Int) -> [TreeNode?] {
        var trees = [TreeNode?]()
        if start > end {
            trees.append(nil)
            return trees
        }
        for i in start ... end {
            let leftTrees = generateTrees(start, i - 1)
            let rightTrees = generateTrees(i + 1, end)
            for left in leftTrees {
                for right in rightTrees {
                    let tree = TreeNode(i)
                    tree.left = left
                    tree.right = right
                    trees.append(tree)
                }
            }
            
        }
        return trees
    }
    
    func numTrees(_ n: Int) -> Int {
        var dp = [Int](repeating: 0, count: n + 1)
        for i in 0 ... n {
            if i < 2 {
                dp[i] = 1
                continue
            }
            for j in 0 ..< i {
                dp[i] += dp[j] * dp[i - j - 1]
            }
        }
        return dp[n]
    }
    
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        let m = s1.count
        let n = s2.count
        if m + n != s3.count {
            return false
        }
        let a1 = Array(s1), a2 = Array(s2), a3 = Array(s3)
        var dp = [[Bool]](repeating: [Bool](repeating: false, count: n + 1), count: m + 1)
        for i in 0 ... m {
            for j in 0 ... n {
                if i == 0, j == 0 {
                    dp[i][j] = true
                }
                if i > 0 {
                    dp[i][j] = dp[i][j] || (dp[i - 1][j] && (a1[i - 1] == a3[i + j - 1]))
                }
                if j > 0 {
                    dp[i][j] = dp[i][j] || (dp[i][j - 1] && (a2[j - 1] == a3[i + j - 1]))
                }
            }
        }
        return dp[m][n]
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        let prev = Int.min
        return isValidBST(root, prev)
    }
    
    func isValidBST(_ root: TreeNode?, _ prev: Int) -> Bool {
        guard let root = root else {
            return true
        }
        if !isValidBST(root.left, prev) {
            return false
        }
        if root.val <= prev {
            return false
        }
        return isValidBST(root.right, root.val)
    }
    
    func recoverTree(_ root: TreeNode?) {
        let stack = Stack<TreeNode>()
        var x: TreeNode? = nil, y: TreeNode? = nil, pred: TreeNode? = nil
        var root = root
        while !stack.isEmpty || root != nil {
            while root != nil {
                stack.push(root!)
                root = root?.left
            }
            root = stack.pop()
            if pred != nil, root!.val < pred!.val {
                y = root
                if x == nil {
                    x = pred
                } else {
                    break
                }
            }
            pred = root
            root = root?.right
        }
        // swap
        let t = x!.val
        x?.val = y!.val
        y?.val = t
    }
    
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        if p == nil || q == nil {
            return false
        }
        if p!.val != q!.val {
            return false
        }
        return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
    }

    func isSymmetric(_ root: TreeNode?) -> Bool {
        return isSymmetric(root, root)
    }
    
    func isSymmetric(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil {
            return true
        }
        if p == nil || q == nil {
            return false
        }
        return p!.val == q!.val && isSymmetric(p?.left, q?.right) && isSymmetric(p?.right, q?.left)
    }
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var ret = [[Int]]()
        guard let root = root else {
            return ret
        }
        let queue = Queue<TreeNode>()
        queue.push(root)
        while !queue.isEmpty {
            var level = [Int]()
            let count = queue.count
            for _ in 0 ..< count {
                if let tree = queue.pop() {
                    level.append(tree.val)
                    queue.push(tree.left)
                    queue.push(tree.right)
                }
            }
            ret.append(level)
        }
        return ret
    }
    
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        var ret = [[Int]]()
        if root == nil {
            return ret
        }
        let queue = Queue<TreeNode>()
        queue.push(root)
        var isOrderLeft = true
        while !queue.isEmpty {
            var level = [Int]()
            let size = queue.count
            for _ in 0 ..< size {
                let node = queue.pop()
                if isOrderLeft {
                    level.append(node!.val)
                } else {
                    level.insert(node!.val, at: 0)
                }
                queue.push(node?.left)
                queue.push(node?.right)
            }
            ret.append(level)
            isOrderLeft = !isOrderLeft
        }
        return ret
    }
    
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
    }
    
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        var inorderMap = [Int:Int]()
        for i in 0 ..< inorder.count {
            inorderMap[inorder[i]] = i
        }
        return buildTree(preorder, 0, preorder.count - 1, inorder, 0, inorder.count - 1, inorderMap)
    }
    
    func buildTree(_ preorder: [Int], _ preorderLeft: Int, _ preorderRight: Int, _ inorder: [Int], _ inorderLeft: Int, _ inorderRight: Int, _ inorderMap: [Int:Int]) -> TreeNode? {
        if preorderLeft > preorderRight { return nil }
        let tree = TreeNode(preorder[preorderLeft])
        let inorderRoot = inorderMap[preorder[preorderLeft]]!
        let leftSize = inorderRoot - inorderLeft
        tree.left = buildTree(preorder, preorderLeft + 1, preorderLeft + leftSize, inorder, inorderLeft, inorderRoot - 1, inorderMap)
        tree.right = buildTree(preorder, preorderLeft + leftSize + 1, preorderRight, inorder, inorderRoot + 1, inorderRight, inorderMap)
        return tree
    }
    
    func buildTree2(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        var inorderMap = [Int:Int]()
        for i in 0 ..< inorder.count {
            inorderMap[inorder[i]] = i
        }
        return buildTree2(postorder, 0, postorder.count - 1, inorder, 0, inorder.count - 1, inorderMap)
    }
    
    func buildTree2(_ postorder: [Int], _ postorderLeft: Int, _ postorderRight: Int, _ inorder: [Int], _ inorderLeft: Int, _ inorderRight: Int, _ inorderMap: [Int:Int]) -> TreeNode? {
        if postorderLeft > postorderRight { return nil }
        let tree = TreeNode(postorder[postorderRight])
        let inorderRoot = inorderMap[postorder[postorderRight]]!
        let leftSize = inorderRoot - inorderLeft
        tree.left = buildTree2(postorder, postorderLeft, postorderLeft + leftSize - 1, inorder, inorderLeft, inorderRoot - 1, inorderMap)
        tree.right = buildTree2(postorder, postorderLeft + leftSize, postorderRight - 1, inorder, inorderRoot + 1, inorderRight, inorderMap)
        return tree
    }
    
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        var ret = [[Int]]()
        guard let root = root else {
            return ret
        }
        let queue = Queue<TreeNode>()
        queue.push(root)
        while !queue.isEmpty {
            var level = [Int]()
            let count = queue.count
            for _ in 0 ..< count {
                if let tree = queue.pop() {
                    level.append(tree.val)
                    queue.push(tree.left)
                    queue.push(tree.right)
                }
            }
            ret.insert(level, at: 0)
        }
        return ret
    }
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        if nums.isEmpty { return nil }
        return sortedArrayToBST(nums, 0, nums.count - 1)
    }
    
    func sortedArrayToBST(_ nums: [Int], _ left: Int, _ right: Int) -> TreeNode? {
        if left > right { return nil }
        let root = left + (right - left) / 2
        let tree = TreeNode(nums[root])
        tree.left = sortedArrayToBST(nums, left, root - 1)
        tree.right = sortedArrayToBST(nums, root + 1, right)
        return tree
    }
    
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        return sortedListToBSTBuild(head, nil)
    }
    
    func sortedListToBSTBuild(_ left: ListNode?, _ right: ListNode?) -> TreeNode? {
        if left?.val == right?.val {
            return nil;
        }
        if let mid = sortedListToBSTMedian(left, right) {
            let tree = TreeNode(mid.val)
            tree.left = sortedListToBSTBuild(left, mid)
            tree.right = sortedListToBSTBuild(mid.next, right)
            return tree
        }
        return nil
    }
    
    func sortedListToBSTMedian(_ left: ListNode?, _ right: ListNode?) -> ListNode? {
        var fast = left
        var slow = left
        while fast?.val != right?.val, fast?.next?.val != right?.val {
            fast = fast?.next
            fast = fast?.next
            slow = slow?.next
        }
        return slow
    }
    
    func isBalanced(_ root: TreeNode?) -> Bool {
        if root == nil { return true }
        let left = isBalancedHeight(root?.left)
        let right = isBalancedHeight(root?.right)
        return abs(left - right) <= 1 && isBalanced(root?.left) && isBalanced(root?.right)
    }
    
    func isBalancedHeight(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        let left = isBalancedHeight(root?.left)
        let right = isBalancedHeight(root?.right)
        return max(left, right) + 1
    }
    
    func minDepth(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        if root?.left == nil, root?.right == nil { return 1 }
        var depth = Int.max
        if let left = root?.left {
            depth = min(depth, minDepth(left))
        }
        if let right = root?.right {
            depth = min(depth, minDepth(right))
        }
        return depth + 1
    }
    
    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        if root == nil { return false }
        if root?.left == nil, root?.right == nil {
            return root!.val == targetSum
        }
        return hasPathSum(root?.left, targetSum - root!.val) || hasPathSum(root?.right, targetSum - root!.val)
    }
    
    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        var ret = [[Int]]()
        var path = [Int]()
        pathSumDFS(root, targetSum, &path, &ret)
        return ret
    }
    
    func pathSumDFS(_ root: TreeNode?, _ targetSum: Int, _ path: inout [Int], _ ret: inout [[Int]]) {
        if root == nil { return }
        path.append(root!.val)
        let sum = targetSum - root!.val
        if root?.left == nil, root?.right == nil, sum == 0 {
            ret.append(path)
        }
        pathSumDFS(root?.left, sum, &path, &ret)
        pathSumDFS(root?.right, sum, &path, &ret)
        path.removeLast()
    }
    
    func flatten(_ root: TreeNode?) {
        var cur = root
        while cur != nil {
            if cur?.left != nil {
                let next = cur?.left
                var pre = next
                while pre?.right != nil {
                    pre = pre?.right
                }
                pre?.right = cur?.right
                cur?.left = nil
                cur?.right = next
            }
            cur = cur?.right
        }
    }
    
    func numDistinct(_ s: String, _ t: String) -> Int {
        let m = s.count
        let n = t.count
        if m < n { return 0 }
        if m == n { return s == t ? 1 : 0 }
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
        for i in 0 ... m {
            dp[i][n] = 1
        }
        let sArr = Array(s)
        let tArr = Array(t)
        var i = m - 1
        while i >= 0 {
            let sChar = sArr[i]
            var j = n - 1
            while j >= 0 {
                let tChar = tArr[j]
                dp[i][j] = dp[i + 1][j]
                if sChar == tChar && dp[i][j] < Int.max - dp[i + 1][j + 1] {
                    dp[i][j] += dp[i + 1][j + 1]
                }
                j -= 1
            }
            i -= 1
        }
        return Int(dp[0][0])
    }
    
    func connect(_ root: Node?) -> Node? {
        let queue = Queue<Node>()
        queue.push(root)
        var prev: Node? = nil
        while !queue.isEmpty {
            let count = queue.count
            for _ in 0 ..< count {
                if let node = queue.pop() {
                    queue.push(node.left)
                    queue.push(node.right)
                    prev?.next = node
                    prev = node
                }
            }
            prev = nil
        }
        return root
    }
 
    func generate(_ numRows: Int) -> [[Int]] {
        var rows = [[Int]]()
        for i in 0 ..< numRows {
            var row = [Int]()
            for j in 0 ... i {
                if j == 0 || j == i {
                    row.append(1)
                } else {
                    row.append(rows[i - 1][j - 1] + rows[i - 1][j])
                }
            }
            rows.append(row)
        }
        return rows
    }
    
    func getRow(_ rowIndex: Int) -> [Int] {
        let rows = generate(rowIndex + 1)
        return rows[rowIndex]
    }
    
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        var sums = triangle.last ?? []
        for i in (0 ..< triangle.count - 1).reversed() {
            for j in 0 ..< triangle[i].count {
                sums[j] = triangle[i][j] + min(sums[j], sums[j + 1])
            }
        }
        return sums.first ?? 0
    }
    
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count <= 1 { return 0 }
        var i = 0, j = 0
        for k in 1 ..< prices.count {
            if prices[i] > prices[k] {
                i = k
            } else if prices[i] < prices[k] {
                j = max(j, prices[k] - prices[i])
            }
        }
        return j
    }
    
    func maxProfit2(_ prices: [Int]) -> Int {
        if prices.count <= 1 { return 0 }
        var j = 0
        for i in 1 ..< prices.count {
            if prices[i] > prices[i - 1] {
                j += prices[i] - prices[i - 1]
            }
        }
        return j
    }
    
    func maxProfit3(_ prices: [Int]) -> Int {
        let n = prices.count
        var buy1 = -prices[0], sell1 = 0
        var buy2 = -prices[0], sell2 = 0
        for i in 1 ..< n {
            buy1 = max(buy1, -prices[i])
            sell1 = max(sell1, buy1 + prices[i])
            buy2 = max(buy2, sell1 - prices[i])
            sell2 = max(sell2, buy2 + prices[i])
        }
        return sell2
    }
    
    func maxPathSum(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        var sum: Int = Int.min
        let _ = maxPathSum(root, &sum)
        return sum
    }
    
    func maxPathSum(_ root: TreeNode?, _ sum: inout Int) -> Int {
        if root == nil { return 0 }
        let left = max(maxPathSum(root?.left, &sum), 0)
        let right = max(maxPathSum(root?.right, &sum), 0)
        sum = max(sum, root!.val + left + right)
        return root!.val + max(left, right)
    }
    
    func isPalindrome(_ s: String) -> Bool {
        if s.count <= 1 { return true }
        let sArr = Array(s)
        let a = Character("a").asciiValue ?? 0
        let z = Character("z").asciiValue ?? 0
        let A = Character("A").asciiValue ?? 0
        let Z = Character("Z").asciiValue ?? 0
        let zero = Character("0").asciiValue ?? 0
        let nine = Character("9").asciiValue ?? 0
        var i = 0, j = sArr.count - 1
        while i < j {
            var p = sArr[i].asciiValue ?? 0
            if (p >= A && p <= Z) {
                p += a - A
            }
            if (p < zero || p > nine) && (p < a || p > z) {
                i += 1
                continue
            }
            var q = sArr[j].asciiValue ?? 0
            if (q >= A && q <= Z) {
                q += a - A
            }
            if (q < zero || q > nine) && (q < a || q > z) {
                j -= 1
                continue
            }
            if p == q {
                i += 1
                j -= 1
            } else {
                return false
            }
        }
        return true
    }
    
    func findLadders(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> [[String]] {
        if !wordList.contains(endWord) { return [] }
        //
        if endWord.count == 1 {
            return [[beginWord, endWord]]
        }
        //
        var beginSubs = [String]()
        var endSubs = [String]()
        findLaddersWordSubs(Array(beginWord), 0, &beginSubs)
        findLaddersWordSubs(Array(endWord), 0, &endSubs)
        //
        if findLaddersIsSimilar(beginSubs, endSubs) {
            return [[beginWord, endWord]]
        }
        // calc sums
        var wordSubs = [String:[String]]()
        wordSubs[beginWord] = beginSubs
        for str in wordList {
            var sums = [String]()
            findLaddersWordSubs(Array(str), 0, &sums)
            wordSubs[str] = sums
        }
        // build tree
        let tree = findLaddersBuildTree(beginWord, wordList, wordSubs)
        var size = Int.max
        var ladders = [[String]]()
        findLaddersDFS(tree, endWord, [], &size, &ladders)
        //
        return ladders
    }
    
    func findLaddersWordSubs(_ s: [Character], _ i: Int, _ subs: inout [String]) {
        for i in 0 ..< s.count {
            var sub = [Character]()
            for j in 0 ..< s.count {
                if j == i {
                    sub.append(" ")
                    continue
                }
                sub.append(s[j])
            }
            subs.append(String(sub))
        }
    }
    
    func findLaddersIsSimilar(_ s: [String], _ t: [String]) -> Bool {
        for i in s {
            if t.contains(i) {
                return true
            }
        }
        return false
    }
    
    func findLaddersBuildTree(_ s: String, _ words: [String], _ sums: [String:[String]]) -> Tree<String> {
        let root = Tree(s)
        var words = words
        var i = 0
        while i < words.count {
            let t = words[i]
            if findLaddersIsSimilar(sums[s]!, sums[t]!) {
                words.remove(at: i)
                root.child.append(findLaddersBuildTree(t, words, sums))
            } else {
                i += 1
            }
        }
        return root
    }
    
    func findLaddersDFS(_ tree: Tree<String>, _ endWord: String, _ path: [String], _ size: inout Int, _ ladders: inout [[String]]) {
        var path = path
        path.append(tree.value)
        if path.count > size {
            return
        }
        if tree.value == endWord {
            if size > path.count {
                ladders.removeAll()
                size = path.count
            }
            ladders.append(path)
            return
        }
        for obj in tree.child {
            findLaddersDFS(obj, endWord, path, &size, &ladders)
        }
    }
    
    func longestConsecutive(_ nums: [Int]) -> Int {
        if nums.count < 2 { return nums.count }
        var map = [Int:Int]()
        for num in nums {
            map[num] = num
        }
        var x = 0, y = 0, z = 0
        for num in nums {
            x = 0
            y = num
            if let _ = map[y - 1] {
                continue
            }
            while map[y] != nil {
                x += 1
                y += 1
            }
            z = max(x, z)
        }
        return z
    }
    
    func sumNumbers(_ root: TreeNode?) -> Int {
        var path = 0, sums = 0
        sumNumbersDFS(root, &path, &sums)
        return sums
    }
    
    func sumNumbersDFS(_ root: TreeNode?, _ path: inout Int, _ sums: inout Int) {
        if root == nil { return }
        path *= 10
        path += root!.val
        if root?.left == nil, root?.right == nil {
            sums += path
        } else {
            sumNumbersDFS(root?.left, &path, &sums)
            sumNumbersDFS(root?.right, &path, &sums)
        }
        path -= root!.val
        path /= 10
    }
    
    func solve(_ board: inout [[Character]]) {
        let m = board.count, n = board[0].count
        if m == 1 || n == 1 { return }
        for i in 0 ..< m {
            solveDFS(&board, i, 0)
            solveDFS(&board, i, n - 1)
        }
        for j in 0 ..< n {
            solveDFS(&board, 0, j)
            solveDFS(&board, m - 1, j)
        }
        let B = Character("B"), O = Character("O"), X = Character("X")
        for i in 0 ..< m {
            for j in 0 ..< n {
                if board[i][j] == B {
                    board[i][j] = O
                } else if board[i][j] == O {
                    board[i][j] = X
                }
            }
        }
    }
    
    func solveDFS(_ board: inout [[Character]], _ i: Int, _ j: Int) {
        let O = Character("O"), B = Character("B")
        let m = board.count, n = board[0].count
        if board[i][j] == O {
            board[i][j] = B
            let bounds = [[-1, 0], [1, 0], [0, -1], [0, 1]]
            for b in bounds {
                let x = i + b[0]
                let y = j + b[1]
                if x >= 0, x < m, y >= 0, y < n, board[x][y] == O {
                    solveDFS(&board, x, y)
                }
            }
        }
    }
    
    func partition(_ s: String) -> [[String]] {
        var sets = [[String]]()
        var path = [String]()
        let sArr = Array(s)
        partitionDFS(sArr, 0, &path, &sets)
        return sets
    }
    
    func partitionDFS(_ s: [Character], _ i: Int, _ path: inout [String], _ sets: inout [[String]]) {
        if i >= s.count {
            sets.append(path)
            return
        }
        for j in i ..< s.count {
            var m = i, n = j, y = true
            while m <= n {
                if s[m] != s[n] {
                    y = false
                    break
                }
                m += 1
                n -= 1
            }
            if y {
                path.append(String(s[i...j]))
                partitionDFS(s, j + 1, &path, &sets)
                path.removeLast()
            }
        }
    }
    
}

