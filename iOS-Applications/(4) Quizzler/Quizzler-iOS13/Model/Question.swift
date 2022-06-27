//
//  Question.swift
//  Quizzler-iOS13
//
//  Logic and Code created by Matias Vargas
//  Material and visual components made London App Brewery through Udemy
//

import Foundation

//  Sets up the questions and what they will have for their own components
struct Question {
    let text: String
    let answer: String
    
    init(q: String, a: String) {
        text = q
        answer = a
    }
}

    
