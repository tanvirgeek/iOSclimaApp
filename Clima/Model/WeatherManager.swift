//
//  WeatherManager.swift
//  Clima
//
//  Created by MD Tanvir Alam on 16/8/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager {
    var weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=1402af63b22f776d8ed539b587f3fc31&units=metric"
    var delegate:WeatherManagerDelegate?
    
    func fetchWeather(cityName:String){
        let urlString = weatherUrl + "&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    func performRequest(with urlString:String){
        // 1. create an URL
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: cityName, temparature: temp)
            return weather
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
