//
//  Calculator.swift
//  Calculator
//
//  Created by 김찬우 on 2021/03/30.
//

import Foundation

struct DecimalCalculator: Addable, Subtractable, TypeConvertible {
    typealias T = Double
    var stack = Stack<Double>()
    var userInputNumber: Double = 0
    var userInputOperator: Operator = .subtraction
    
    func divide(_ operatedNumber: Double, by operatingNumber: Double) throws -> Double {
        if operatingNumber != 0 {
            return operatedNumber / operatingNumber
        }
        throw DecimalCalculatorError.divideFailed
    }
    
    func multiply(_ operatedNumber: Double, by operatingNumber: Double) -> Double {
        return operatedNumber * operatingNumber
    } 
    
    func convertType(inputNumber: String?) -> Double {
        guard let number = inputNumber else { return 0 }
        guard let userInputNumber = Double(number) else { return 0 }
        return userInputNumber
    }
    
    func convertType(inputOperator: String?) -> Operator? {
        guard let userInputOperator = inputOperator else { fatalError() }
        switch userInputOperator {
        case "+":
            return Operator.addition
        case "-":
            return Operator.subtraction
        case "*":
            return Operator.multiplication
        case "/":
            return Operator.division
        default:
            return nil // 짜자잔~
        }
    }
    
    mutating func calculate(operateSign: String?, operatedNumber: Double, operatingNumber: Double) -> Double {
        switch convertType(inputOperator: operateSign) {
        case .addition:
           return add(operatedNumber, and: operatingNumber)
        case .subtraction:
            return subtract(operatedNumber, and: operatingNumber)
        case .multiplication:
            return multiply(operatedNumber, by: operatingNumber)
        case .division:
            do {
             return try divide(operatedNumber, by: operatingNumber)
            } catch {
                print("0으로 나눌 수 없습니다.")
                return 0
            }
        default: return 0
        }
    }
    
    mutating func executeOperate(of inputNumber: String?) {
        stack.push(convertType(inputNumber: inputNumber))
        
        for _ in 1...10 {
                stack.push(calculate(operateSign: readLine(), operatedNumber: stack.pop()!, operatingNumber: convertType(inputNumber: readLine())))
        } 
    }
    
    func showTopOfStack() -> Double {
        if stack.top! / 1000000000.0 >= 1 {
            return stack.top!.truncatingRemainder(dividingBy: 1000000000.0)
        } else {
            return stack.top!
        }
    }
    
//    do {
//     try executeOperate
//    } catch {
//        switch error {
//        case DecimalCalculatorError.divideFailed:
//            print("0으로는 나눌 수가 없습니다.")
//        case DecimalCalculatorError.otherOperators:
//            print("사칙연산자를 제외한 연산자는 사용할 수 없습니다.")
//        default:
//            print("알 수 없는 에러 입니다.")
//        }
//    }
}


