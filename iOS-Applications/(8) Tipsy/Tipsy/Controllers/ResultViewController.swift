//
//  ResultViewController.swift
//  Tipsy
//
//  Logic and Code created by Matias Vargas
//  Material and visual components made London App Brewery through Udemy
//

import UIKit

//  This is the second screen controller
class ResultViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    // Sets up some basic values in case the bill text field in the previews screen is empty
    var totalPerPerson: Float = 0.0
    var totalPeople = "2"
    var tipAmount = "10%"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalLabel.text = "$" + String(format: "%.2f", totalPerPerson)
        settingsLabel.text = "Split between \(totalPeople) people, with \(tipAmount) tip"

    }
    
    //  Dismisses this screen to go back to the calculate screen
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
