//
//  CalculatorBrain.swift
//  Tipsy
//
//  Logic and Code created by Matias Vargas
//  Material and visual components made London App Brewery through Udemy
//


import Foundation

//  This struct is used as the calculator brain
//  This just controls the tip and the bill total
struct CalculatorBrain{
    var tipAmmount: Float? = 0.0
    var billTotal: Float? = 0.0
    
    mutating func setTipAmount(amount: Float){
        tipAmmount = amount
    }
    
    mutating func setBillTotal (amount: Float){
        billTotal = amount
    }
}
