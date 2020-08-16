//
//  WeatherData.swift
//  Clima
//
//  Created by MD Tanvir Alam on 16/8/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData:Decodable {
    let name:String
    let main: Main
    let weather: [Weather]
}

struct Main:Decodable {
    let temp: Float
}

struct Weather:Decodable {
    //weather[0].id
    let description : String
}
