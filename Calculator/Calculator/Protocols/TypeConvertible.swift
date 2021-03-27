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

extension TypeConvertible {
    func inputAndConvertType() -> T {
        guard let userInput = readLine(),
              let TypeConvertedUserInput = userInput as? T else { fatalError() }
        
        return TypeConvertedUserInput
    }
}
