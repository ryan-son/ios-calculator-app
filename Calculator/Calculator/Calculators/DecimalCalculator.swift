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
    
    mutating func executeAddition(with userInput: Double, and previousOperator: Operator) {
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
        operatingSequence.push(.addition)
    }
    
    mutating func executeSubtraction(with userInput: Double, and previousOperator: Operator) {
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
        operatingSequence.push(.subtraction)
    }
    
    mutating func executeMultiplication(with userInput: Double, and previousOperator: Operator) {
        if previousOperator == .multiplication {
            let poppedElement: Double = stack.pop() ?? 1
            multiply(poppedElement, and: userInput)
        } else if previousOperator == .division {
            let poppedElement: Double = stack.pop() ?? 1
            divide(poppedElement, and: userInput)
            operatingSequence.push(.multiplication)
        } else {
            stack.push(userInput)
            operatingSequence.push(.multiplication)
        }
    }
    
    mutating func executeDivision(with userInput: Double, and previousOperator: Operator) {
        if previousOperator == .multiplication {
            let poppedElement: Double = stack.pop() ?? 1
            multiply(poppedElement, and: userInput)
            operatingSequence.push(.division)
        } else if previousOperator == .division {
            let poppedElement: Double = stack.pop() ?? 1
            divide(poppedElement, and: userInput)
        }  else {
            stack.push(userInput)
            operatingSequence.push(.division)
        }
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
            executeAddition(with: userInput, and: previousOperator)
        case .subtraction:
            executeSubtraction(with: userInput, and: previousOperator)
        case .multiplication:
            executeMultiplication(with: userInput, and: previousOperator)
        case .division:
            executeDivision(with: userInput, and: previousOperator)
        default:
            print("십진 계산에 적합하지 않은 연산자입니다.")
        }
    }
}
