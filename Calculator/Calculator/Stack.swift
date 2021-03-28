//
//  Stack.swift
//  Calculator
//
//  Created by Coda, Summer, Ryan on 2021/03/26.
//

import Foundation

struct Stack<T>: CustomStringConvertible {
    private(set) var list: [T] = []
    var isEmpty: Bool { return self.list.isEmpty }
    var top: T? { return self.list.last }
    
    mutating func push(_ item: T) {
        self.list.append(item)
    }
    
    mutating func pop() -> T? {
        return self.list.popLast()
    }
    
    mutating func reset() {
        self.list.removeAll()
    }
    
    var description: String {
        return "\(self.list)"
    }
}

extension Stack where T: Numeric {
    mutating func sumAllElements() -> T {
        let sumResult: T = self.list.reduce(0) { (result, currentItem) -> T in
            return result + currentItem
        }
        
        return sumResult
    }
    
    mutating func subtractAllElements() -> T {
        let subtractResult: T = self.list.reduce((self.list.first ?? 0) * 2) { (result, currentItem) -> T in
            return result - currentItem
        }
        
        return subtractResult
    }
}

extension Stack where T: Equatable {
    func contains(_ element: T) -> Bool {
        return list.contains { $0 == element }
    }
}
