//
//  WeatherData.swift
//  Clima
//
//  Created by Matias Vargas on 2/24/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
}

struct Weather: Codable {
    let description: String //This is in case you want to use it later
    let id: Int
}
