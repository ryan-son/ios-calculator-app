//
//  CalculationMethodSwitchable.swift
//  Calculator
//
//  Created by 김찬우 on 2021/03/27.
//

import Foundation

protocol CalculationExecutable {
    mutating func executeCalculation(of _operator: Operator)
}
