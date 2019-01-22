//
//  WeatherDetailController.swift
//  WeatherApp
//
//  Created by Oniel Rosario on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//high, low, sunrise, sunset, windspeed and precipitation

import UIKit

class WeatherDetailController: UIViewController {
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var detailNameandDate: UILabel!
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var highF: UILabel!
    @IBOutlet weak var lowF: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var precipitation: UILabel!
    public var cityName: String!
    private var formattedCityName: String {
        return cityName.replacingOccurrences(of: " ", with: "+")
    }
    public var forecast: Period!
    private var image = [Image]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI(forecast: forecast)
    }
    
    public func setupUI(forecast: Period) {
        backGroundImage.loadGif(name: "sunny")
        detailNameandDate.text = "\(cityName!) forecast for: \(forecast.dateFormattedString)"
        detailNameandDate.textColor = .white
        weatherAPIClient.getCities(url: "https://pixabay.com/api/?key=\(Keys.pixaBayKey)&q=\(self.formattedCityName)&image_type=photo") { (appError, images) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let images = images {
                self.image = images
            }
            ImageHelper.shared.fetchImage(urlString: self.image[0].largeImageURL, completionHandler: { (appError, myImage) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let myImage = myImage {
                    self.cityImage.image = myImage
                }
            })
        }
        weatherDescription.text = forecast.weather
        weatherDescription.textColor = .white
        highF.text = "\(forecast.maxTempF)"
        highF.textColor = .white
        lowF.text = "\(forecast.minTempF)"
        highF.textColor = .white
        sunrise.text = "\(forecast.sunriseFormattedString)"
        sunrise.textColor = .white
        sunset.text = "\(forecast.sunsetFormattedString)"
        sunset.textColor = .white
        windSpeed.text = "Wind Speed: \(forecast.windSpeedMPH)MPH"
        windSpeed.textColor = .white
        precipitation.textColor = .white
        precipitation.text = "Precipitacion: \(forecast.precipIN)"
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    
}
