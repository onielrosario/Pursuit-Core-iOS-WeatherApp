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
    }
    private func getForecast() {
        weatherAPIClient.getWeather { (appError, response) in
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
        cell.highF.text = "\(weather.maxTempF)"
        cell.lowF.text = "\(weather.minTempF)"
        cell.forecastImage.image = UIImage(named: "\(weather.iconImage)")
        return cell
    }
}
