//
//  CurrentWeather.swift
//  ProjectWeather
//
//  Created by Opentechbox on 18/6/2565 BE.
//

import Foundation

import Foundation

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let weather: [Weather]
    let main: Main
}

// MARK: - Main
struct Main: Codable {
    let temp : Double
    let pressure, humidity: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
