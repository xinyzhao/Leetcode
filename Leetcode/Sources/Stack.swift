import Foundation

public class Stack<T> {
    fileprivate var list = [T]()
    public var count: Int { return list.count }
    public var isEmpty: Bool { return count == 0 }
    public init() {}
    public func push(_ element: T) { list.append(element) }
    public func pop() -> T? { list.isEmpty ? nil : list.removeLast() }
    public func peek() -> T? { list.last }
}
