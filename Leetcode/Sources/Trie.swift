//
//  Trie.swift
//  Leetcode
//
//  Created by xyz on 2023/8/13.
//

import Foundation

class Trie {
    var child = [Character:Trie]()
    var isEnd = false

    init() {}
    
    func insert(_ word: String) {
        var trie = self
        for ch in word {
            if let next = trie.child[ch] {
                trie = next
            } else {
                let next = Trie()
                trie.child[ch] = next
                trie = next
            }
        }
        trie.isEnd = true
    }
    
    func searchPrefix(_ prefix: String) -> Trie? {
        var trie = self
        for ch in prefix {
            if let next = trie.child[ch] {
                trie = next
            } else {
                return nil
            }
        }
        return trie
    }
    
    func search(_ word: String) -> Bool {
        if let node = searchPrefix(word) {
            return node.isEnd
        }
        return false
    }
    
    func startsWith(_ prefix: String) -> Bool {
        return searchPrefix(prefix) != nil
    }
}
