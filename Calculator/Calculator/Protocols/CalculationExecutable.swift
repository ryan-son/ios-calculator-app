//
//  CalculationMethodSwitchable.swift
//  Calculator
//
//  Created by 김찬우 on 2021/03/27.
//

import Foundation

protocol CalculationExecutable {
    associatedtype Operator
    
    mutating func executeCalculation(of operator: Operator)
}
