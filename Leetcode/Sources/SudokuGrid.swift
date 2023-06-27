//
//  SudukuGird.swift
//  Leetcode
//
//  Created by xyz on 2023/6/27.
//

import Foundation

class SudokuGrid {
    var x: Int = 0
    var y: Int = 0
    var z: Int { (x / 3) * 3 + y / 3 }
    var values = [Character]()
    
    init() {}
    init(x: Int, y: Int) { self.x = x; self.y = y; }
    
    func merge(_ line: [Character], _ column: [Character], _ block: [Character]) {
        values.removeAll()
        for c in block {
            if line.contains(c), column.contains(c) {
                values.append(c)
            }
        }
    }
}
