//
//  ViewController.swift
//  Calculator
//
//  Created by Pat Escalona on 2/23/15.
//  Copyright (c) 2015 Pat Escalona. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var operandDisplay: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        println("user entered a \(digit)")
    
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            enter()
            userIsInTheMiddleOfTypingANumber = true
        }
        println("digit = \(digit)")
    }

    @IBAction func appendOperand(sender: UIButton) {
        let operand = sender.currentTitle!
        if (operand == "C" ) {
            operandDisplay.text = ""
        } else {
        operandDisplay.text = operandDisplay.text! + operand
        println("operand = \(operand)")
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        //let opCharacter = sender.currentTitle!
        if let operation = sender.currentTitle  {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }

    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = .DecimalStyle
            numberFormatter.maximumFractionDigits = 10
            display.text = numberFormatter.stringFromNumber(newValue)
            userIsInTheMiddleOfTypingANumber = false
        }
    
    }

}