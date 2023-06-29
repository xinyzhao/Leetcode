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
        var m = [[1,2,3], [4,5,6], [7,8,9]]
        Solution().rotate(&m)
        print(m)
        var n = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
        Solution().rotate(&n)
        print(n)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testList() {
        var list: ListNode?
        for i in 0 ..< 2 {
            let p = list
            list = ListNode(2 - i)
            list?.next = p
        }
        //
        var node = Solution().reverseKGroup(list, 2)
        var arr = [String]()
        while node != nil {
            if let val = node?.val {
                arr.append("\(val)")
            }
            node = node?.next
        }
        let str = "[\(arr.joined(separator: ","))]"
        print(str)
    }
    
    func testNums() {
        var nums = [0,1,2,2,3,0,4,2]
        print(">\(nums)")
        let len = Solution().removeElement(&nums, 2)
        print("#\(len)")
        print("<\(nums)")
    }
    
}
