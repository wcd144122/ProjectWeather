//
//  CurrentWeatherViewModel.swift
//  ProjectWeather
//
//  Created by Opentechbox on 18/6/2565 BE.
//

import Foundation

class CurrentWeatherViewModel : NSObject {
    
    private var apiService : APIService!
    var cityId: Int! {
        didSet {
            self.callFuncToGetCurrentCityWeather()
        }
    }
    private(set) var currentWeather: CurrentWeather! {
        didSet {
            self.bindCurrentWeatherViewModelToController()
        }
    }
    private(set) var forecast5Weather: Forecast5Weather! {
        didSet {
            self.bindCurrentWeatherViewModelToRoute()
        }
    }
    
    var bindCurrentWeatherViewModelToController : (() -> ()) = {}
    var bindCurrentWeatherViewModelToRoute : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
    }
    
    func callFuncToGetCurrentCityWeather() {
        self.apiService.getGetCurrentCityWeather(cityId: self.cityId) { (currentWeather) in
            self.currentWeather = currentWeather
        }
    }
    
    func callFuncToGetForecast5Weather() {
        guard let cityId = self.cityId else {
            return
        }
        self.apiService.getForecast5(cityId: cityId) { (forecast5Weather) in
            self.forecast5Weather = forecast5Weather
        }
    }
}
