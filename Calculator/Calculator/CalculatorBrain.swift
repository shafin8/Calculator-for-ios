//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by shafin haq on 23/1/18.
//  Copyright © 2018 shafin. All rights reserved.
//

import Foundation




struct CalculatorBrain {
    
    private var accumulattor: Double?
    
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
        
    }
    
    private var operations: Dictionary<String,Operation> = [
        
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "sin" :  Operation.unaryOperation(sin),
        "cos" :  Operation.unaryOperation(cos),
        "tan" :  Operation.unaryOperation(tan),
        "±" : Operation.unaryOperation({ -$0 } ),
        "×" : Operation.binaryOperation({ $0 * $1 } ),
        "÷" : Operation.binaryOperation({ $0 / $1 } ),
        "+" : Operation.binaryOperation({ $0 + $1 } ),
        "-" : Operation.binaryOperation({ $0 - $1 } ),
        "=" : Operation.equals,
        "^" : Operation.binaryOperation({pow($0, $1)}),
        "CE" : Operation.constant(0),
        "log" : Operation.unaryOperation({log($0)}),
        "1/x" : Operation.unaryOperation({1/$0}),
        "%" : Operation.unaryOperation({ $0 * (1/100) })
        
        ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value): accumulattor = value
                
            case .unaryOperation(let function):
                if accumulattor != nil {
                    accumulattor = function(accumulattor!)
                }
                
            case .binaryOperation(let function):
                if accumulattor != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulattor!)
                    accumulattor = nil
                }
                
            case .equals:
                performPendingBinaryOperation()
                
           
                
                
            }
        }
    }
    
    private mutating func performPendingBinaryOperation(){
        if pendingBinaryOperation != nil && accumulattor != nil {
            accumulattor = pendingBinaryOperation!.perform(with: accumulattor!)
            pendingBinaryOperation = nil
        }
    }
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation{
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double ) -> Double {
            return function(firstOperand, secondOperand)
        }
        
    }
    
    mutating func setOperand(_ operand: Double)  {
        accumulattor = operand
    }
    
    var result: Double?{
        get{
            return accumulattor
        }
    }
    
}
