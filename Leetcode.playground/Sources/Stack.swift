import Foundation

public class Stack {
    fileprivate var list = [Any]()
    public var count: Int { return list.count }
    public var isEmpty: Bool { return count == 0 }
    public init() {}
    public func push(_ element: Any) { list.append(element) }
    public func pop() -> Any? { list.isEmpty ? nil : list.removeLast() }
    public func peek() -> Any? { list.last }
}
