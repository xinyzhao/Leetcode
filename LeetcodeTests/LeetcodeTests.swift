//
//  LeetcodeTests.swift
//  LeetcodeTests
//
//  Created by xyz on 2023/6/23.
//

import XCTest
@testable import Leetcode

class LeetcodeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print(Solution().wordBreak2("pineapplepenapple", ["apple","pen","applepen","pine","pineapple"]))
    }
    
    func testNode() throws {
        var node = Node.buildRandomNode([[3,nil], [3,0], [3, nil]])
        Node.printNode(node)
        let copy = Solution().copyRandomList(node)
        Node.printNode(copy)
    }
    
    func testListNode() throws {
        let list = ListNode.makeList([1,2,3,4])
        Solution().reorderList(list)
        ListNode.printList(list)
    }
    
    func testTree() {
        let tree = Tree(0, [1,2,3])
        tree.print()
    }
    
    func testTreeNode() throws {
        let tree = TreeNode.make([0,1])
        var path = [Int]()
        tree?.preorderRecursive(&path)
        print(path)
        print(Solution().sumNumbers(tree))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSortList() {
        let l0 = [9,8,7,6,5,4,3,2,1]
        print("unsort:")
        print(l0)
        
        print("bubbleSort:")
        let l1 = SortList<Int>.bubbleSort(l0) { i,j in
            return i < j
        }
        print(l1)
        
        print("selectionSort:")
        let l2 = SortList<Int>.selectionSort(l0) { i,j in
            return i < j
        }
        print(l2)
        
        print("insertionSort:")
        let l3 = SortList<Int>.insertionSort(l0) { i,j in
            return i < j
        }
        print(l3)
        
        print("shellSort:")
        let l4 = SortList<Int>.shellSort(l0) { i,j in
            return i < j
        }
        print(l4)
        
        print("mergeSort:")
        let l5 = SortList<Int>.mergeSort(l0) { i,j in
            return i < j
        }
        print(l5)
        
        print("quickSort:")
        let l6 = SortList<Int>.quickSort(l0) { i,j in
            return i < j
        }
        print(l6)
        
        print("heapSort:")
        let l7 = SortList<Int>.heapSort(l0) { i,j in
            return i < j
        }
        print(l7)
        
        print("countingSort:")
        let l8 = SortList<Int>.countingSort(l0)
        print(l8)
        
        print("bucketSort:")
        let l9 = SortList<Int>.bucketSort(l0)
        print(l9)
        
        print("radixSort:")
        let la = SortList<Int>.radixSort(l0)
        print(la)
    }
}
