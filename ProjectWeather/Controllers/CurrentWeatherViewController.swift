//
//  CurrentWeatherViewController.swift
//  ProjectWeather
//
//  Created by Opentechbox on 18/6/2565 BE.
//

import UIKit
import Alamofire
import AlamofireImage
import iOSDropDown
import ActivityIndicatorManager

class CurrentWeatherViewController: UIViewController {
    
    @IBOutlet weak var cityDropDown: DropDown!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    private var cityViewModel: CityViewModel!
    private var currentWeatherViewModel: CurrentWeatherViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
        hideKeyboardWhenTapScreen()
        setUpNavigationBar()
    }
    
    func hideKeyboardWhenTapScreen() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setUpNavigationBar() {
        title = "Weather App"
        
        let forecast5BarBtn: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "clock.arrow.circlepath"), style: .done, target: self, action: #selector(getForecast5Weather))
        forecast5BarBtn.tintColor = .white
        navigationItem.rightBarButtonItem = forecast5BarBtn
    }
    
    @objc func getForecast5Weather() {
        AIMActivityIndicatorManager.sharedInstance.shouldShowIndicator()
        self.currentWeatherViewModel.callFuncToGetForecast5Weather()
    }
    
    @IBAction func changeTempTypeAction(_ sender: UIButton) {
        let kelvin = self.currentWeatherViewModel.currentWeather.main.temp
        if sender.tag == 1 {
            sender.tag = 0
            self.temperatureLabel.text = String(format: "%.2f °C", kelvin - 273)
        } else {
            sender.tag = 1
            self.temperatureLabel.text = String(format: "%.2f °F",  1.8 * (kelvin - 273) + 32)
        }
    }
    
    func callToViewModelForUIUpdate() {
        self.cityViewModel = CityViewModel()
        self.cityViewModel.bindCityViewModelToController = {
            self.updateCityData()
        }
        self.cityViewModel.callFuncToGetCityList()
        
        self.currentWeatherViewModel = CurrentWeatherViewModel()
        self.currentWeatherViewModel.bindCurrentWeatherViewModelToController = {
            self.updateCurrentCityWeather()
        }
        self.currentWeatherViewModel.bindCurrentWeatherViewModelToRoute = {
            self.routeToForecast5WeatherView()
        }
    }
    
    private func updateCityData() {
        let cityListName = self.cityViewModel.cityList.map { $0.name }
        let cityListId = self.cityViewModel.cityList.map { $0.id }
        cityDropDown.optionArray = cityListName
        cityDropDown.optionIds = cityListId
        cityDropDown.didSelect{(selectedText , index ,id) in
            self.title = selectedText
            self.currentWeatherViewModel.cityId = id
            AIMActivityIndicatorManager.sharedInstance.shouldShowIndicator()
        }
    }
    
    private func updateCurrentCityWeather(){
        self.weatherView.isHidden = false
        if let icon = self.currentWeatherViewModel.currentWeather.weather.first?.icon,
           let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
            weatherImage.af.setImage(withURL: url)
        }
        self.weatherNameLabel.text = self.currentWeatherViewModel.currentWeather.weather.first?.main
        self.temperatureLabel.text = String(format: "%.2f °C", self.currentWeatherViewModel.currentWeather.main.temp - 273)
        self.humidityLabel.text = String(self.currentWeatherViewModel.currentWeather.main.humidity)
        AIMActivityIndicatorManager.sharedInstance.forceHideIndicator()
    }
    
    private func routeToForecast5WeatherView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "Forecast5WeatherViewController") as? Forecast5WeatherViewController else {
            return
        }
        vc.forecast5Weather = self.currentWeatherViewModel.forecast5Weather
        AIMActivityIndicatorManager.sharedInstance.forceHideIndicator()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
