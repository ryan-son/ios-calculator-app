//
//  AddableProtocol.swift
//  Calculator
//
//  Created by 김찬우 on 2021/03/26.
//

import Foundation

protocol Addable {
    associatedtype T: Numeric
    
    var stack: Stack<T> { get set }
    mutating func add(_ operatedNumber: T, and operatingNumber: T)
}

extension Addable {
    mutating func add(_ operatedNumber: T, and operatingNumber: T) {
        stack.push(operatedNumber + operatingNumber)
    }
}
