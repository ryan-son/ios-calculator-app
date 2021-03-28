//
//  AddableProtocol.swift
//  Calculator
//
//  Created by Coda, Summer, Ryan on 2021/03/26.
//

import Foundation

protocol Addable {
    associatedtype T: Numeric
    
    var stack: Stack<T> { get set }
    func add(_ operatedNumber: T, and operatingNumber: T) -> T
}

extension Addable {
    func add(_ operatedNumber: T, and operatingNumber: T) -> T {
        return operatedNumber + operatingNumber
    }
}
