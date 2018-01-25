//
//  ViewController.swift
//  Calculator
//
//  Created by shafin haq on 18/1/18.
//  Copyright © 2018 shafin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    
    
    @IBAction func touchDigit(_  sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay+digit
        }
            
        else
        { display.text=digit
            userIsInTheMiddleOfTyping=true
        }
        
        
        
    }
    
    
    var displayValue: Double  {
        
        get {
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
   
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
         userIsInTheMiddleOfTyping = false
        }
       
      

        if let mathematicalSymbol = sender.currentTitle{
        brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result{
        displayValue = result
        }
    }
    
    
}

