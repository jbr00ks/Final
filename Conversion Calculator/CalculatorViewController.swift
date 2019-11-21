//
//  CalculatorViewController.swift
//  Conversion Calculator
//
//  Created by Joshua Brooks on 10/29/19.
//  Copyright © 2019 Joshua Brooks. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var inputValue: Double? = 0
    var inputString: String = ""
    var outputValue: Double = 0
    var outputString: String = ""
    var number = ""
    var converterChoice = 0

    var converters = [Converter(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C", choice: 0),
                      Converter(label: "celcius to farenheit", inputUnit: "°C", outputUnit: "°F", choice: 1),
                      Converter(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km", choice: 2),
                      Converter(label: "kilometers to miles", inputUnit: "km", outputUnit: "mi", choice: 3)]
    
    var selectedConverter: Converter?
    
    @IBOutlet weak var outputDisplay: UITextField!
    @IBOutlet weak var inputDisplay: UITextField!
    
    func conversion(inputValue: Double) -> Double {
        switch converterChoice {
        case 0:
            return round(1000*((inputValue - 32) * (5/9)))/1000
        case 1:
            return round(1000*((inputValue * (9/5)) + 32))/1000
        case 2:
            return round(1000*(inputValue * 1.60934))/1000
        case 3:
            return round(1000*(inputValue / 1.60934))/1000
        default:
            print("Converter not valid")
        }
        return -1
    }
    
    @IBAction func converter(_ sender: Any) {
        let alert = UIAlertController(title: "Choose converter", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        for converter in converters {
            alert.addAction(UIAlertAction(title: converter.label, style: UIAlertAction.Style.default, handler: {
                (alertAction) -> Void in
                self.selectedConverter = converter
                self.converterChoice = converter.choice
                self.outputValue = self.conversion(inputValue: self.inputValue!)
                self.outputString = String(self.outputValue)
                self.outputDisplay.text = self.outputString + converter.outputUnit
                self.inputDisplay.text = self.inputString + converter.inputUnit
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func numPressed(_ sender: UIButton) {
        number = String(sender.tag)
        inputString = inputString + number
        inputValue = Double(inputString)
        outputValue = conversion(inputValue: inputValue!)
        outputString = String(outputValue)
        inputDisplay.text = inputString + selectedConverter!.inputUnit
        outputDisplay.text = outputString + selectedConverter!.outputUnit
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        inputValue = 0
        inputString = ""
        self.inputDisplay.text = selectedConverter?.inputUnit
        outputValue = 0
        outputString = ""
        outputDisplay.text = selectedConverter?.outputUnit
    }
    
    @IBAction func positiveNegative(_ sender: UIButton) {
        if inputString.prefix(1) == "-" {
            inputString = String(inputString.dropFirst())
            inputValue = Double(inputString)
        } else {
            inputString = "-" + inputString
            inputValue = Double(inputString)
        }
        outputValue = conversion(inputValue: inputValue!)
        outputString = String(outputValue)
        inputDisplay.text = inputString + selectedConverter!.inputUnit
        outputDisplay.text = outputString + selectedConverter!.outputUnit
    }
    
    @IBAction func decimalPressed(_ sender: UIButton) {
        if inputString.contains(".") {
            print("Decimal already exists")
        } else {
            inputString = inputString + "."
            inputValue = Double(inputString)
            outputValue = conversion(inputValue: inputValue!)
            outputString = String(outputValue)
            inputDisplay.text = inputString + selectedConverter!.inputUnit
            outputDisplay.text = outputString + selectedConverter!.outputUnit
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedConverter = converters[0]
        outputDisplay.text = selectedConverter?.outputUnit
        inputDisplay.text = selectedConverter?.inputUnit
    }
}
