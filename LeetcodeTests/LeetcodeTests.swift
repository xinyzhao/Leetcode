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
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSortList() {
        let l0 = [9,1,2,5,7,4,8,6,3,5]
        print("unsort:\t\(l0)")
        
        let l1 = SortList<Int>.bubbleSort(l0) { i,j in
            return i > j
        }
        print("bubbleSort:\t\(l1)")
        
        let l2 = SortList<Int>.selectionSort(l0) { i,j in
            return i > j
        }
        print("selectionSort:\t\(l2)")
        
        let l3 = SortList<Int>.insertionSort(l0) { i,j in
            return i > j
        }
        print("insertionSort:\t\(l3)")
        
        let l4 = SortList<Int>.shellSort(l0) { i,j in
            return i > j
        }
        print("shellSort:\t\(l4)")
        
        let l5 = SortList<Int>.quickSort(l0) { i,j in
            return i > j
        }
        print("quickSort:\t\(l5)")
        
        let l6 = SortList<Int>.mergeSort(l0) { i,j in
            return i > j
        }
        print("mergeSort:\t\(l6)")
        
        let l7 = SortList<Int>.heapSort(l0) { i,j in
            return i > j
        }
        print("heapSort:\t\(l7)")
        
        let l8 = SortList<Int>.countingSort(l0) { i,j in
            return i > j
        }
        print("countingSort:\t\(l8)")
        
        let l9 = SortList<Int>.bucketSort(l0) { i,j in
            return i > j
        }
        print("bucketSort:\t\(l9)")
        
        let la = SortList<Int>.radixSort(l0) { i,j in
            return i > j
        }
        print("radixSort:\t\(la)")
    }
}
