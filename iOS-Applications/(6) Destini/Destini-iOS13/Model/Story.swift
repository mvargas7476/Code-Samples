//
//  Story.swift
//  Destini-iOS13
//
//  Logic and Code created by Matias Vargas
//  Material and visual components made London App Brewery through Udemy
//

import Foundation

//  This sets up the basic type of story and the components it will use
struct Story {
    let title: String
    let choice1: String
    let choice2: String
    let choice1Destination: Int
    let choice2Destination: Int
    
    init(t: String, c1: String, c1D: Int, c2: String, c2D: Int){
        title = t
        choice1 = c1
        choice2 = c2
        choice1Destination = c1D
        choice2Destination = c2D
    }
    
}
