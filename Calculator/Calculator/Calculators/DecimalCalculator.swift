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
    var operatingSequence = Stack<Operator>()
    var userInput: Double = 0
    
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
        guard let previousOperator: Operator = operatingSequence.top else {
            stack.push(userInput)
            operatingSequence.push(_operator)
            return
        }
        
        switch _operator {
        case .addition:
            if previousOperator == .addition {
                let poppedElement: Double = stack.pop() ?? 0
                add(poppedElement, and: userInput)
            } else if previousOperator == .subtraction {
                let poppedElement: Double = stack.pop() ?? 0
                subtract(poppedElement, and: userInput)
            } else if previousOperator == .multiplication {
                if operatingSequence.contains(.subtraction) {
                    let poppedElement: Double = stack.pop() ?? 0
                    multiply(poppedElement, and: userInput)
                    let result = stack.subtractAllElements()
                    stack.reset()
                    stack.push(result)
                } else {
                    let poppedElement: Double = stack.pop() ?? 0
                    multiply(poppedElement, and: userInput)
                    let result = stack.sumAllElements()
                    stack.reset()
                    stack.push(result)
                }
            } else if previousOperator == .division {
                if operatingSequence.contains(.subtraction) {
                    let poppedElement: Double = stack.pop() ?? 0
                    divide(poppedElement, and: userInput)
                    let result = stack.subtractAllElements()
                    stack.reset()
                    stack.push(result)
                } else {
                    let poppedElement: Double = stack.pop() ?? 0
                    divide(poppedElement, and: userInput)
                    let result = stack.sumAllElements()
                    stack.reset()
                    stack.push(result)
                }
            }
            operatingSequence.reset()
            operatingSequence.push(_operator)
        case .subtraction:
            if previousOperator == .addition {
                let poppedElement: Double = stack.pop() ?? 0
                add(poppedElement, and: userInput)
            } else if previousOperator == .subtraction {
                let poppedElement: Double = stack.pop() ?? 0
                subtract(poppedElement, and: userInput)
            } else if previousOperator == .multiplication {
                if operatingSequence.contains(.addition) {
                    let poppedElement: Double = stack.pop() ?? 0
                    multiply(poppedElement, and: userInput)
                    let result = stack.sumAllElements()
                    stack.reset()
                    stack.push(result)
                } else {
                    let poppedElement: Double = stack.pop() ?? 0
                    multiply(poppedElement, and: userInput)
                    let result = stack.subtractAllElements()
                    stack.reset()
                    stack.push(result)
                }
            } else if previousOperator == .division {
                if operatingSequence.contains(.addition) {
                    let poppedElement: Double = stack.pop() ?? 0
                    divide(poppedElement, and: userInput)
                    let result = stack.sumAllElements()
                    stack.reset()
                    stack.push(result)
                } else {
                    let poppedElement: Double = stack.pop() ?? 0
                    divide(poppedElement, and: userInput)
                    let result = stack.subtractAllElements()
                    stack.reset()
                    stack.push(result)
                }
            }
            operatingSequence.reset()
            operatingSequence.push(_operator)
        case .multiplication:
            if previousOperator == .multiplication {
                let poppedElement: Double = stack.pop() ?? 1
                multiply(poppedElement, and: userInput)
            } else if previousOperator == .division {
                let poppedElement: Double = stack.pop() ?? 1
                divide(poppedElement, and: userInput)
                operatingSequence.push(_operator)
            }
        case .division:
            if previousOperator == .multiplication {
                let poppedElement: Double = stack.pop() ?? 1
                multiply(poppedElement, and: userInput)
                operatingSequence.push(_operator)
            } else if previousOperator == .division {
                let poppedElement: Double = stack.pop() ?? 1
                divide(poppedElement, and: userInput)
            }
        default:
            print("십진 계산에 적합하지 않은 연산자입니다.")
        }
    }
}
