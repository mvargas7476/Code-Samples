//
//  ViewController.swift
//  Destini-iOS13
//
//  Logic and Code created by Matias Vargas
//  Material and visual components made London App Brewery through Udemy
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    var storyBrain = StoryBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  This sets up the app start up screen
        storyLabel.text = storyBrain.getQuestionText()
        choice1Button.setTitle(storyBrain.getChoiceOneText(), for: .normal)
        choice2Button.setTitle(storyBrain.getChoiceTwoText(), for: .normal)

    }

    //  Here the user made a choice by clicking on the button
    @IBAction func choiceMade(_ sender: UIButton) {
        storyBrain.nextStory(userChoice: sender.currentTitle!)
        updateUI()
    }
    
    //  Updates the User Interface once the choice has been made by the user
    func updateUI(){
        storyLabel.text = storyBrain.getQuestionText()
        choice1Button.setTitle(storyBrain.getChoiceOneText(), for: .normal)
        choice2Button.setTitle(storyBrain.getChoiceTwoText(), for: .normal)
    }
}

