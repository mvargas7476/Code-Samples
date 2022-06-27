//
//  CoinData.swift
//  ByteCoin
//
//  Created by Matias Vargas on 3/30/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

// Codable protocol could also be used if you wanted to move things back into JSON.
// Decoding moves it from JSON to what you need, and Encodable cna code it to JSON.
struct CoinData: Decodable{
    
    //This is the only thing I care about from the bitcoins
    //this is called rate because you this is how it will be displayed by the API
    let rate: Double
}
