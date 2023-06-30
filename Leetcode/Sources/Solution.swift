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
}

