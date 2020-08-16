//
//  WeatherManager.swift
//  Clima
//
//  Created by MD Tanvir Alam on 16/8/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    var weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=1402af63b22f776d8ed539b587f3fc31&units=metric"
    func fetchWeather(cityName:String){
        let urlString = weatherUrl + "&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    func performRequest(urlString:String){
        // 1. create an URL
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    self.parseJSON(weatherData: safeData)
                }
            }
            task.resume()
        }
    }
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
            //weather[0].description
        }catch{
            print(error)
        }
    }
}
