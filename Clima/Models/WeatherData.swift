//
//  WeatherData.swift
//  Clima
//
//  Created by ReviseUC73 on 2/2/2567 BE.
//

import Foundation
// strutre data model from api
// Decodeable -> json to obj model
// Encodeable -> obj to json
struct WeatherData:Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    
}

struct Weather: Codable {
    let description: String 
    let id:Int
}
