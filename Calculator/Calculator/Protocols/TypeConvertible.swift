//
//  TypeConvertible.swift
//  Calculator
//
//  Created by 김찬우 on 2021/03/27.
//

import Foundation

protocol TypeConvertible {
    associatedtype T
    
    var userInput: T { get set }
    func inputAndConvertType() -> T
}
