//
//  WeatherModel.swift
//  Weather
//
//  Created by Parth Patel on 2024-07-31.
//


import Foundation

struct WeatherModel: Codable {
    let name: String
    let sys: Sys
    let main: Main
    let wind: Wind
    let weather: [Weather]
    
    struct Sys: Codable {
        let sunrise: Int
        let sunset: Int
        let country: String
    }
    
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let pressure: Int
        let humidity: Int
    }
    struct Wind: Codable {
        let speed: Double
    }
    
    struct Weather: Codable, Hashable {
        let main: String
        let description: String
        //let icon: Image
    }
}
