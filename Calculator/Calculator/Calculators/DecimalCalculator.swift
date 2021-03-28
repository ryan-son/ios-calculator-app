//
//  DecimalCalculator.swift
//  Calculator
//
//  Created by Coda, Summer, Ryan on 2021/03/26.
//

import Foundation

struct DecimalCalculator: Addable,
                          Subtractable,
                          Resetable,
                          CalculationExecutable,
                          TypeConvertible {
    var stack = Stack<Double>()
    private var operatingSequence = Stack<Operator>()
    
    mutating func reset() {
        stack.reset()
    }
    
    private mutating func multiply(_ operatedNumber: Double, and operatingNumber: Double) {
        stack.push(operatedNumber * operatingNumber)
    }
    
    private mutating func divide(_ operatedNumber: Double, and operatingNumber: Double) {
        stack.push(operatedNumber / operatingNumber)
    }
    
    func inputAndConvertType() -> Double {
        guard let userInput = readLine(),
              let TypeConvertedUserInput = Double(userInput) else { fatalError() }
        
        return TypeConvertedUserInput
    }
    
    private mutating func executeAddition(with userInput: Double, and previousOperator: Operator) {
        let poppedElement: Double = stack.pop() ?? 0
        
        if previousOperator == .addition {
            add(poppedElement, and: userInput)
        } else if previousOperator == .subtraction {
            subtract(poppedElement, and: userInput)
        } else if previousOperator == .multiplication {
            executeAdditionWherePreviousOperatorIsMultiplication(with: userInput, and: poppedElement)
        } else if previousOperator == .division {
            executeAdditionWherePreviousOperatorIsDivision(with: userInput, and: poppedElement)
        } else {
            print("이전 연산자가 없는데 여기까지 왔어요.. 무슨일이죠..? \(#function)")
        }
        operatingSequence.reset()
        operatingSequence.push(.addition)
    }
    
    private mutating func executeAdditionWherePreviousOperatorIsMultiplication(with userInput: Double,
                                                                               and poppedElement: Double) {
        if operatingSequence.contains(.subtraction) {
            multiply(poppedElement, and: userInput)
            let result = stack.subtractAllElements()
            stack.reset()
            stack.push(result)
        } else {
            multiply(poppedElement, and: userInput)
            let result = stack.sumAllElements()
            stack.reset()
            stack.push(result)
        }
    }
    
    private mutating func executeAdditionWherePreviousOperatorIsDivision(with userInput: Double,
                                                                         and poppedElement: Double) {
        if operatingSequence.contains(.subtraction) {
            divide(poppedElement, and: userInput)
            let result = stack.subtractAllElements()
            stack.reset()
            stack.push(result)
        } else {
            divide(poppedElement, and: userInput)
            let result = stack.sumAllElements()
            stack.reset()
            stack.push(result)
        }
    }
    
    private mutating func executeSubtraction(with userInput: Double, and previousOperator: Operator) {
        let poppedElement: Double = stack.pop() ?? 0
        
        if previousOperator == .addition {
            add(poppedElement, and: userInput)
        } else if previousOperator == .subtraction {
            subtract(poppedElement, and: userInput)
        } else if previousOperator == .multiplication {
            executeSubtractionWherePreviousOperatorIsMultiplication(with: userInput, and: poppedElement)
        } else if previousOperator == .division {
            executeSubtractionWherePreviousOperatorIsDivision(with: userInput, and: poppedElement)
        } else {
            print("이전 연산자가 없는데 여기까지 왔어요.. 무슨일이죠..? \(#function)")
        }
        operatingSequence.reset()
        operatingSequence.push(.subtraction)
    }
    
    private mutating func executeSubtractionWherePreviousOperatorIsMultiplication(with userInput: Double,
                                                                                  and poppedElement: Double) {
        if operatingSequence.contains(.addition) {
            multiply(poppedElement, and: userInput)
            let result = stack.sumAllElements()
            stack.reset()
            stack.push(result)
        } else {
            multiply(poppedElement, and: userInput)
            let result = stack.subtractAllElements()
            stack.reset()
            stack.push(result)
        }
    }
    
    private mutating func executeSubtractionWherePreviousOperatorIsDivision(with userInput: Double,
                                                                            and poppedElement: Double) {
        if operatingSequence.contains(.addition) {
            divide(poppedElement, and: userInput)
            let result = stack.sumAllElements()
            stack.reset()
            stack.push(result)
        } else {
            divide(poppedElement, and: userInput)
            let result = stack.subtractAllElements()
            stack.reset()
            stack.push(result)
        }
    }
    
    private mutating func executeMultiplication(with userInput: Double, and previousOperator: Operator) {
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
    
    private mutating func executeDivision(with userInput: Double, and previousOperator: Operator) {
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
