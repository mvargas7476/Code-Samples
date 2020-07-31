//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "65A12F88-D770-44C2-AB5C-E3A96A92CF66"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String){
        
        // Use string concatenatiosn to make up the correct way to go to the website using API
        let urlString = "\(baseURL)/\(currency)/?apikey=\(apiKey)"
        
        // Use optional unwrapping to get the url using the string above
        if let url = URL(string: urlString){
            
            // Create the URL session with default configuration
            let session = URLSession(configuration: .default)
            
            //Create the task for the URL Session
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    
                    if let bitcoinPrice = self.parseJSON(safeData){
                        
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                    }
                }
            }
            
            // Start task to fetch data from bitcoins average's servers
            task.resume()
        }
    }
    
    func parseJSON (_ data: Data) -> Double? {
        
        // Cereates teh decoder for the data that you are getting
        let decoder = JSONDecoder()
        
        do{
            
            //try to decode the data by using the CoinData Structure
            let decodeData = try decoder.decode(CoinData.self, from: data)
            
            //get the last price by calling on the rate
            let lastPrice = decodeData.rate
            //print(lastPrice)
            return lastPrice
            
        } catch {
            
            //catch and print any errors
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
