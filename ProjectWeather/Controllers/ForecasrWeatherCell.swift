//
//  ForecasrWeatherCell.swift
//  ProjectWeather
//
//  Created by Opentechbox on 19/6/2565 BE.
//

import UIKit
import Alamofire
import AlamofireImage

class ForecasrWeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var data: List! {
        didSet {
            if let icon = data.weather.first?.icon,
               let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                let placeholderImage = UIImage(systemName: "cloud.fill")
                weatherImage.af.setImage(withURL: url, placeholderImage: placeholderImage)
            }
            
            let date = Date(timeIntervalSince1970: TimeInterval(data.dt))
            let format = DateFormatter()
            format.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
            format.timeZone = TimeZone.current
            dateLabel.text = format.string(from: date)
            temperatureLabel.text = String(format: "Temperature: %.2f °C", data.main.temp - 273)
            humidityLabel.text = "Humidity: \(String(data.main.humidity))"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.2)
    }
}
