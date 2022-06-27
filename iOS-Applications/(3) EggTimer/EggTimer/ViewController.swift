//
//  ViewController.swift
//  EggTimer
//
//  Logic and Code created by Matias Vargas
//  Material and visual components made London App Brewery through Udemy
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!

    
    //This is a dictionary, they seem like enumeration types
    //if you want to be specific about the data types, do it this way. Not needed
    //let eggTimes : [String : Int] = ["Soft": 300, "Medium": 420,"Hard": 720]

    let eggTimes = ["Soft": 300, "Medium": 420,"Hard": 720]
    
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    //This is used so that we can access things for timer. Such as the invalidate function
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        //Stop timer when a button is pushed
        timer.invalidate()
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        totalTime = eggTimes[hardness]!//Based on hardness, totalTime is set harndess to 300, 420, 720 respectively
        
        //  Setting up the progress bar
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        //  Using the times and changing the progress bar by using the update timer function
        timer = Timer.scheduledTimer(timeInterval: 1.0,target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    //  Updates teh time, and the progress bar
    @objc func updateTimer(){
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed)/Float(totalTime)
            progressBar.progress = percentageProgress
        } else{
            timer.invalidate()
            titleLabel.text = "Done!"
            playSound(soundName: "alarm_sound")
        }
    }
    
    //  Plays the sound when the timer ends
    func playSound(soundName: String){
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
   
}


