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
        var sumResult: T = 0
        for element in self.list {
            sumResult += element
        }
        
        return sumResult
    }
    
    mutating func subtractAllElements() -> T {
        var sumResult: T = 0
        for element in self.list {
            sumResult -= element
        }
        
        return sumResult
    }
}

extension Stack where T: Equatable {
    func contains(_ element: T) -> Bool {
        return list.contains { $0 == element }
    }
}
