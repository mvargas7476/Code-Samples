//
//  CurrencyManager.swift
//  ByteCoin
//
//  Created by Matias Vargas on 3/30/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

protocol CurrencyManagerDelegate{
    //func didUpdateWeather (_ currencyManager: CurrencyManager, currency: CurrencyModel)
    func didFailWithError (error: Error)
}

struct CurrencyManager {
// API key is appended from the git-ignored Secrets.plist (see README) rather than hard-coded.
let currencyURL = "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=\(CoinManager.loadAPIKey())"

var delegate: CurrencyManagerDelegate?

    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession (configuration: .default)
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
}
