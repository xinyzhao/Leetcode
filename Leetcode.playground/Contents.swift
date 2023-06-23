import UIKit

var list: ListNode?
for i in 0 ..< 5 {
    let p = list
    list = ListNode(5 - i)
    list?.next = p
}
//
var node = Solution().reverseKGroup(list, 3)
var arr = [String]()
while node != nil {
    if let val = node?.val {
        arr.append("\(val)")
    }
    node = node?.next
}
let str = "[\(arr.joined(separator: ","))]"
print(str)
