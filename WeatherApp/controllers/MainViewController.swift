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
    public var city = ""
    private var forecast = [Period]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        collectionView.dataSource = self
         backGroundImage.loadGif(name: "wathBackground")
        collectionView.layer.cornerRadius = 5
        getForecast()
        ZipCodeHelper.getLocationName(from: isZipCode()) { (error, cityName) in
            if let error = error {
                print("error: \(error)")
            } else if let cityName = cityName {
               self.city = cityName
              self.cityName.text = "Weather forecast for \(cityName)"
            }
        }
    zipCode.text = "Enter your Zip Code"
    
    }
    
    private func isZipCode() -> String {
        var zipCode = ""
        if textField.text == "" {
         return "10023"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? WeatherDetailController else { fatalError("error in the segue") }
        destination.cityName = city.lowercased()
      guard let selectedArray = collectionView.indexPathsForSelectedItems else {return}
       let selectedIndexPathRow = selectedArray[0].row
    destination.forecast = forecast[selectedIndexPathRow]
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionCell else { return UICollectionViewCell() }
         let weather = forecast[indexPath.row]
        cell.weeklyDate.text = "\(weather.dateFormattedString)"
        cell.highF.text = "High: \(weather.maxTempF)°F"
        cell.lowF.text = "Low: \(weather.minTempF)°F"
        cell.forecastImage.image = UIImage(named: "\(weather.iconImage)")
        cell.layer.cornerRadius = 5
        return cell
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
       textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
       textField.placeholder = "e.g 10023"
        print("ended editing")
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
      getForecast()
        ZipCodeHelper.getLocationName(from: isZipCode()) { (error, cityName) in
            if let error = error {
                print("error: \(error)")
            } else if let cityName = cityName {
                self.cityName.text = "Weather forecast for \(cityName)"
            }
        }
        return true
    }
    
}
