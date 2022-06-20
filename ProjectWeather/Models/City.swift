//
//  City.swift
//  ProjectWeather
//
//  Created by Opentechbox on 18/6/2565 BE.
//

import Foundation

// MARK: - CurrentWeatherElement
struct City: Codable {
    let id: Int
    let name, country: String
    let coord: Coord
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}
