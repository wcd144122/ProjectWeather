//
//  Forecast5WeatherViewController.swift
//  ProjectWeather
//
//  Created by Opentechbox on 19/6/2565 BE.
//

import UIKit
import Alamofire
import AlamofireImage

class Forecast5WeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var forecast5Weather: Forecast5Weather!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 8
    }
}

extension Forecast5WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast5Weather.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecasrWeatherCell") as! ForecasrWeatherCell
        let data = forecast5Weather.list[indexPath.row]
        cell.data = data
        return cell
    }
}
