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
    func subtract(_ operatedNumber: T, and operatingNumber: T) -> T
}

extension Subtractable {
    func subtract(_ operatedNumber: T, and operatingNumber: T) -> T {
        return operatedNumber - operatingNumber
    }
}
