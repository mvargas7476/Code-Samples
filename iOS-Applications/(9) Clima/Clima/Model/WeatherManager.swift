//
//  WeatherManager.swift
//  Clima
//
//  Created by Matias Vargas on 2/24/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather (_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError (error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=52d7691be4280602f2cc05882989544e&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
        }
    
    func performRequest(with urlString: String){
        //1. create URL
        if let url = URL(string: urlString) {
            //2. Create URL Sessions
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){ //you have to add the self because I am inside a closure!
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }//Closure ends here
            
            //4. Start the task
            task.resume()
        }
    }
    
    //This decodes the data downloaded
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder ()
        
        do {
            let  decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditiondID: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

