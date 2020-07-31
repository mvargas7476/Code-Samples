//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Logic and Code created by Matias Vargas
//  Material and visual components made London App Brewery through Udemy
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    // This lets you calculate the BMI from the components given
    mutating func calculateBMI(height: Float, weight: Float){
        
        let bmiValue = weight / pow(height,2)
        
        //  Based on what the value of BMI different advice and color is displayed on the screen
        if bmiValue < 18.5{
            bmi = BMI(value: bmiValue, advice: "Eat more cake", color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
        } else if bmiValue < 24.9{
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle", color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less cake", color: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        }
    }
    
    //  Gets the basic components from the BMI. While also setting some basic values
    func getBMIValue () -> String{
        let bmiFormatted = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiFormatted
    }
    
    func getColor() -> UIColor{
        return bmi?.color ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func getAdvice() -> String{
        return bmi?.advice ?? "No advice"
    }
    
}
