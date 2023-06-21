import Foundation

struct Stack {
    fileprivate var list = [Any]()
    
    mutating func push(_ element: Any) {
        list.append(element)
    }
    
    mutating func pop() -> Any? {
        return list.removeLast()
    }
    
    func peek() -> Any? {
        return list.last
    }
}
