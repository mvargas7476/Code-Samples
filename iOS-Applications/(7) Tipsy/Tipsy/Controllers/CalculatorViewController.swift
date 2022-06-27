//
//  ViewController.swift
//  Tipsy
//
//  Logic and Code created by Matias Vargas
//  Material and visual components made London App Brewery through Udemy
//

import UIKit

//  This controls the main calculator screen, where the user can input the values for the tip
class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPCButton: UIButton!
    @IBOutlet weak var tenPCButton: UIButton!
    @IBOutlet weak var twentyPCButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var calculatorBrain = CalculatorBrain()
    
    //  Controls the tip percentage button that is pressed by highlighting and setting the tip amount
    @IBAction func tipChange(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        zeroPCButton.isSelected = false
        tenPCButton.isSelected = false
        twentyPCButton.isSelected = false
        sender.isSelected = true
        
        if sender.currentTitle! == "0%"{
            calculatorBrain.setTipAmount(amount: 0.0)
        } else if sender.currentTitle! == "10%"{
            calculatorBrain.setTipAmount(amount: 0.1)
        } else if sender.currentTitle! == "20%"{
            calculatorBrain.setTipAmount(amount: 0.2)
        }
    }
    
    //  Controls the stepper value for the number of people present
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }
    
    //  Goes to the next screen once the button is pressed
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let billPaid = billTextField.text!
        
        //  Checks to see if the bill text field is not empty
        if billPaid != ""{
            let bill = Float(billPaid)!
            let totalPeople = Float(splitNumberLabel.text!)!
            let totalFinal = (bill + (bill * calculatorBrain.tipAmmount!)) / totalPeople
            calculatorBrain.setBillTotal(amount: totalFinal)
        }
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    //  Prepares the values for the next screen to display them
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //  Makes sure that the correct segue is being accessed at this point
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultViewController
            
                destinationVC.totalPerPerson = calculatorBrain.billTotal!
                destinationVC.totalPeople = splitNumberLabel.text!
                destinationVC.tipAmount = String(format: "%.0f", calculatorBrain.tipAmmount! * 100 ) + "%"
            }
            
        }
    }


