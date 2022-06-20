//
//  CityViewModel.swift
//  ProjectWeather
//
//  Created by Opentechbox on 18/6/2565 BE.
//

import Foundation

class CityViewModel : NSObject {
    private(set) var cityList: [City]! {
        didSet {
            self.bindCityViewModelToController()
        }
    }
    
    var bindCityViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
    }
    
    func callFuncToGetCityList() {
        if let path = Bundle.main.path(forResource: "city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode([City].self, from: data)
                self.cityList = result
            } catch let error {
                print("\(error.localizedDescription)")
            }
        }
    }
}
