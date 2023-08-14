//
//  WordDictionary.swift
//  Leetcode
//
//  Created by xyz on 2023/8/14.
//

import Foundation

class WordDictionary {
    var child = [Character:WordDictionary]()
    var isEnd = false

    init() {}
    
    func addWord(_ word: String) {
        var trie = self
        for ch in word {
            if let next = trie.child[ch] {
                trie = next
            } else {
                let next = WordDictionary()
                trie.child[ch] = next
                trie = next
            }
        }
        trie.isEnd = true
    }
    
    func search(_ word: String) -> Bool {
        return searchWord(word, 0)
    }
    
    func searchWord(_ word: String, _ i: Int) -> Bool {
        if i == word.count {
            return isEnd
        }
        let ch = Array(word)[i]
            if isLetter(ch) {
                if let next = child[ch], next.searchWord(word, i + 1) {
                    return true
                }
            } else {
                for (_,v) in child {
                    if v.searchWord(word, i + 1) {
                        return true
                    }
                }
            }
        return false
    }
    
    func isLetter(_ ch: Character) -> Bool {
        let a = Character("a").asciiValue!
        let z = Character("z").asciiValue!
        let A = Character("A").asciiValue!
        let Z = Character("Z").asciiValue!
        if let v = ch.asciiValue {
            if v >= a, v <= z { return true }
            if v >= A, v <= Z { return true }
        }
        return false
    }
    
}

