//
//  CalculationMethodSwitchable.swift
//  Calculator
//
//  Created by 김찬우 on 2021/03/27.
//

import Foundation

protocol CalculationMethodSwitchable {
    associatedtype Operator
    
    func switchCalculationMethod(to operator: Operator)
}
