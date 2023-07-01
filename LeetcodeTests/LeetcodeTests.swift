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
        let l0 = [9,8,7,6,5,4,3,2,1]
        let l1 = SortList<Int>.bubbleSort(l0) { i,j in
            return i > j
        }
        print("bubbleSort:\(l1)")
        let l2 = SortList<Int>.selectionSort(l0) { i,j in
            return i > j
        }
        print("selectionSort:\(l2)")
        let l3 = SortList<Int>.insertionSort(l0) { i,j in
            return i > j
        }
        print("insertionSort:\(l3)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
