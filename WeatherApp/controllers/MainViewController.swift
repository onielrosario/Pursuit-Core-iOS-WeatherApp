//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var zipCode: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    private var forecast = [Period]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         backGroundImage.loadGif(name: "wathBackground")
        collectionView.dataSource = self
        getForecast()
        var city = ""
        ZipCodeHelper.getLocationName(from: isZipCode()) { (error, cityName) in
            if let error = error {
                print("error: \(error)")
            } else if let cityName = cityName {
                city = cityName
              self.cityName.text = "Weather forecast for \(city)"
            }
        }
    
    
    }
    
    private func isZipCode() -> String {
        var zipCode = ""
        if textField.text == "" {
            textField.text = "10023"
        }
         guard let searchText = textField.text else { return "Invalid Zipcode" }
       zipCode.append(searchText)
        guard zipCode.count == 5 else {
            return "text entered not invalid"
        }
        if !(Int(zipCode) != nil) {
            return "text entered not invalid"
        }
        return zipCode
    }
    
    
    private func getForecast() {
        weatherAPIClient.getWeather(keyword: isZipCode()) { (appError, response) in
            if let appError = appError {
                print(AppError.errorMessage(appError))
            } else if let response = response {
           let allForecast = response[response.count - 1].periods
                self.forecast = allForecast
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionCell else { return UICollectionViewCell() }
         let weather = forecast[indexPath.row]
        cell.weeklyDate.text = "\(weather.dateTimeISO)"
        cell.highF.text = "High: \(weather.maxTempF)°"
        cell.lowF.text = "Low: \(weather.minTempF)°"
        cell.forecastImage.image = UIImage(named: "\(weather.iconImage)")
        cell.layer.cornerRadius = 5
        return cell
    }
}
