//
//  WeatherData.swift
//  Clima
//
//  Created by MD Tanvir Alam on 16/8/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData:Codable {
    let name:String
    let main: Main
    let weather: [Weather]
}

struct Main:Codable {
    let temp: Double
}

struct Weather:Codable {
    //weather[0].id
    let id : Int
}
