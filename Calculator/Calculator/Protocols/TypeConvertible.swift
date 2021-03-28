//
//  TypeConvertible.swift
//  Calculator
//
//  Created by Coda, Summer, Ryan on 2021/03/27.
//

import Foundation

protocol TypeConvertible {
    associatedtype T
    
    func inputAndConvertType() -> T
}
