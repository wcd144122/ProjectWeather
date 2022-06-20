//
//  Forecast5Weather.swift
//  ProjectWeather
//
//  Created by Opentechbox on 19/6/2565 BE.
//

import Foundation

// MARK: - Forecast5Weather
struct Forecast5Weather: Codable {
    let list: [List]
    let city: City
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
}
