//
//  CalculationMethodSwitchable.swift
//  Calculator
//
//  Created by Coda, Summer, Ryan on 2021/03/27.
//

import Foundation

protocol CalculationExecutable {
    mutating func executeCalculation(of _operator: Operator)
}
