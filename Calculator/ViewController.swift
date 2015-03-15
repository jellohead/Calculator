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
        // userIsInTheMiddleOfTypingANumber clears display to get rid of leading 0 when entering numbers
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        println("digit = \(digit)")
    }
    
    @IBAction func operate(sender: UIButton) {
        let opCharacter = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        operandDisplay.text = operandDisplay.text! + opCharacter
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
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

