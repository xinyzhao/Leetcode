import Foundation

public struct Stack {
    fileprivate var list = [Any]()
    
    public var count: Int { return list.count }
    
    public mutating func push(_ element: Any) {
        list.append(element)
    }
    
    public mutating func pop() -> Any? {
        if !list.isEmpty {
            return list.removeLast()
        }
        return nil
    }
    
    public func peek() -> Any? {
        return list.last
    }
}
