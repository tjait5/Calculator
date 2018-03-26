//
//  CalculatorViewController.swift
//  TJ-Calculator
//
//  Copyright © 2018 TJ. All rights reserved.
//

import UIKit

enum Operation:String {
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case Modulo = "%"
    case NULL = "Null"
}

class CalculatorViewController: UIViewController {
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation:Operation = .NULL
    var currentOperationButton:CalculatorButton?

    @IBOutlet weak var outputLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLbl.text = "0"
    }
    
    //MARK::Helpers
    func operation(operation: Operation) {
        if currentOperation != .NULL {
            if runningNumber != "" {
                rightValue = removeCommas(string: runningNumber)
                runningNumber = ""
                
                switch(currentOperation){
                case .Add:
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                    break
                case .Subtract:
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                    break
                case .Multiply:
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                    break
                case .Divide:
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                    break
                case .Modulo:
                    result = "\(Double(leftValue)!.truncatingRemainder(dividingBy: Double(rightValue)!))"
                    break
                default:
                    NSLog("Error")
                }
                
                leftValue = result
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                outputLbl.text = insertCommas(string: result)
            }
            currentOperation = operation
            
        }else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    func setHighlight(button: CalculatorButton){
        button.inverseHighlight()
        currentOperationButton = button
    }
    
    func clearHighlight(){
        if let currentOperationButton = currentOperationButton{
            currentOperationButton.inverseHighlight()
        }
        currentOperationButton = nil
    }
    
    func insertCommas(string: String) -> String{
        if(string.count >= 4){
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            return numberFormatter.string(from: NSNumber(value: Double(string)!))!
        }
        else{
            return string
        }
    }
    
    func removeCommas(string: String) -> String{
        return string.replacingOccurrences(of: ",", with: "")
    }
    
    //MARK::IBActions
    @IBAction func numberPressed(_ sender: CalculatorButton) {
        if runningNumber.count <= 8 {
         
            //If number begins with 0, then just replace string with entered number
            if(runningNumber.first == "0"){
                runningNumber = "\(sender.tag)"
            }
            else{
                runningNumber += "\(sender.tag)"
            }
            outputLbl.text = insertCommas(string: runningNumber)
            clearHighlight()
        }
    }
    @IBAction func allClearPressed(_ sender: UIButton) {
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .NULL
        outputLbl.text = "0"
        clearHighlight()
    }
    @IBAction func dotPressed(_ sender: UIButton) {
        if(runningNumber.count <= 7 && !runningNumber.contains(".")){
            runningNumber += "."
            outputLbl.text = runningNumber
            clearHighlight()
        }
    }
    @IBAction func equalPressed(_ sender: UIButton) {
        clearHighlight()
        operation(operation: currentOperation)
    }
    
    @IBAction func operationPressed(_ sender: CalculatorButton) {
        let selectedOperation = Operation.init(rawValue: (sender.titleLabel?.text)!)
        if let selectedOperation = selectedOperation{
            clearHighlight()
            setHighlight(button: sender)
            operation(operation: selectedOperation)
        }
    }
}
