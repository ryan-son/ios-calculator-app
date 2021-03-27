//
//  DecimalCalculator.swift
//  Calculator
//
//  Created by 김찬우 on 2021/03/26.
//

import Foundation

struct DecimalCalculator: Addable,
                          Subtractable,
                          Resetable,
                          CalculationMethodSwitchable,
                          TypeConvertible {
    var stack = Stack<Double>()
    var userInput: Double
    
    mutating func reset() {
        stack.reset()
    }
    
    func switchCalculationMethod(to _operator: Operator) {
        switch _operator {
        case .addition:
            print("Addition method")
        case .subtraction:
            print("Subtraction method")
        case .multiplication:
            print("Multiplication method")
        case .division:
            print("Division method")
        default:
            print("십진 계산에 적합하지 않은 연산자입니다.")
        }
    }
}
