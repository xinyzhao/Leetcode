import Foundation

/// FILO/LIFO Queue
open class Stack<T>: Queue<T> {
    open override func pop() -> T? { list.isEmpty ? nil : list.removeLast() }
    open func peek() -> T? { list.last }
    open func sequence() -> [T] { list }
    open func reversed() -> [T] { list.reversed() }
}
