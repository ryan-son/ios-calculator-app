//
//  SubtractableProtocol.swift
//  Calculator
//
//  Created by Coda, Summer, Ryan on 2021/03/26.
//

import Foundation

protocol Subtractable {
    associatedtype T: Numeric
    
    var stack: Stack<T> { get set }
    mutating func subtract(_ operatedNumber: T, and operatingNumber: T)
}

extension Subtractable {
    mutating func subtract(_ operatedNumber: T, and operatingNumber: T) {
        stack.push(operatedNumber - operatingNumber)
    }
}
