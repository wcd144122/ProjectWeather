//
//  GetCityWeather.swift
//  ProjectWeather
//
//  Created by Opentechbox on 18/6/2565 BE.
//

import Foundation
import Alamofire

extension APIService {
    func getGetCurrentCityWeather(cityId: Int, completion : @escaping (CurrentWeather) -> ()){
        let urlString = "\(openweathermap_url)weather?id=\(cityId)&appid=\(api_key)"
        AF.request(urlString).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(CurrentWeather.self, from: data)
                completion(result)
            } catch let error {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func getForecast5(cityId: Int, completion : @escaping (Forecast5Weather) -> ()){
        let urlString = "\(openweathermap_url)forecast?id=\(cityId)&appid=\(api_key)"
        AF.request(urlString).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(Forecast5Weather.self, from: data)
                completion(result)
            } catch let error {
                print("\(error.localizedDescription)")
            }
        }
    }
}
