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
    private var images = [Image]() {
        didSet {
            DispatchQueue.main.async {
                self.cityImage.reloadInputViews()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI(forecast: forecast)
    }
    
    public func setupUI(forecast: Period) {
        backGroundImage.loadGif(name: "sunny")
        detailNameandDate.text = "\(cityName!.capitalized) forecast for: \(forecast.dateFormattedString)"
        detailNameandDate.textColor = .white
        weatherAPIClient.getCities(url: "https://pixabay.com/api/?key=\(Keys.pixaBayKey)&q=\(self.formattedCityName)&image_type=photo") { (appError, images) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let images = images {
                self.images = images
            }
            guard self.images.count > 0 else {
                return 
            }
            let imageURL = self.images[Int.random(in: 0..<self.images.count - 1)].largeImageURL
            ImageHelper.shared.fetchImage(urlString: imageURL , completionHandler: { (appError, myImage) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let myImage = myImage {
                    self.cityImage.image = myImage
                }
            })
        }
        weatherDescription.text = "\(forecast.weather)"
        weatherDescription.shadowColor = .black
        weatherDescription.shadowOffset = CGSize(width: 1, height: 1)
        weatherDescription.textColor = .white
        highF.text = "High: \(forecast.maxTempF)°F"
        highF.textColor = .white
        highF.shadowColor = .black
        highF.shadowOffset = CGSize(width: 1, height: 1)
        lowF.text = "Low: \(forecast.minTempF)°F"
        lowF.textColor = .white
        lowF.shadowColor = .black
        lowF.shadowOffset = CGSize(width: 1, height: 1)
        sunrise.text = "\(forecast.sunriseFormattedString)"
        sunrise.textColor = .white
        sunrise.shadowColor = .black
        sunrise.shadowOffset = CGSize(width: 1, height: 1)
        sunset.text = "\(forecast.sunsetFormattedString)"
        sunset.textColor = .white
        sunset.shadowColor = .black
        sunset.shadowOffset = CGSize(width: 1, height: 1)
        windSpeed.text = "Wind Speed: \(forecast.windSpeedMPH)MPH"
        windSpeed.textColor = .white
        windSpeed.shadowColor = .black
        windSpeed.shadowOffset = CGSize(width: 1, height: 1)
        precipitation.textColor = .white
        precipitation.text = "Precipitacion: \(forecast.precipIN)' inches"
        precipitation.shadowColor = .black
        precipitation.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        print("happened")
        let alert = UIAlertController(title: "Saved", message: "Your message has been saved to favorite", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default){
            _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
