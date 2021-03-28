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
                          CalculationExecutable,
                          TypeConvertible {
    var stack = Stack<Double>()
    var userInput: Double
    
    mutating func reset() {
        stack.reset()
    }
    
    mutating func multiply(_ operatedNumber: Double, and operatingNumber: Double) {
        stack.push(operatedNumber * operatingNumber)
    }
    
    mutating func divide(_ operatedNumber: Double, and operatingNumber: Double) {
        stack.push(operatedNumber / operatingNumber)
    }
    
    func inputAndConvertType() -> Double {
        guard let userInput = readLine(),
              let TypeConvertedUserInput = Double(userInput) else { fatalError() }
        
        return TypeConvertedUserInput
    }
    
    mutating func executeCalculation(of _operator: Operator) {
        let userInput = inputAndConvertType()
        guard let poppedElement = stack.pop() else { fatalError() }
        
        switch _operator {
        case .addition:
            let sumResult = stack.sumAllElements()
            stack.reset()
            add(sumResult, and: userInput)
        case .subtraction:
            let subtractResult = stack.subtractAllElements()
            stack.reset()
            subtract(subtractResult, and: userInput)
        case .multiplication:
            multiply(poppedElement, and: userInput)
        case .division:
            divide(poppedElement, and: userInput)
        default:
            print("십진 계산에 적합하지 않은 연산자입니다.")
        }
    }
}
