import Foundation

public class ListNode: Equatable {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val && lhs.next == rhs.next
    }
}

extension ListNode {
    static public func makeList(_ list: [Int]) -> ListNode? {
        var head: ListNode?, next: ListNode?
        for val in list {
            if next == nil {
                next = ListNode(val)
            } else {
                next?.next = ListNode(val)
                next = next?.next
            }
            if head == nil {
                head = next
            }
        }
        return head
    }
    
    static public func printList(_ list: ListNode?) {
        var vals = [String]()
        var list = list
        while let node = list {
            vals.append("\(node.val)")
            list = list?.next
        }
        print("[\(vals.joined(separator: ","))]")
    }
}
