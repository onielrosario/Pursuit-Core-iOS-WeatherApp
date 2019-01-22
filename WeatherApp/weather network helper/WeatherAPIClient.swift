//
//  weatherAPIClient.swift
//  WeatherApp
//
//  Created by Oniel Rosario on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


final class weatherAPIClient {
    static func getWeather(keyword: String, completionHandler: @escaping (AppError?, [Response]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "http://api.aerisapi.com/forecasts/\(keyword)?client_id=\(Keys.accessID)&client_secret=\(Keys.AerisKey)", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode(String(statusCode)), nil)
                    return
            }
            if let data = data {
                do {
                    let weather = try JSONDecoder().decode(Weather.self, from: data)
                    completionHandler(nil , weather.response)
                    
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    static func getCities(url: String, completionhandler: @escaping(AppError?, [Image]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: url, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionhandler(appError, nil)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionhandler(AppError.badStatusCode(String(statusCode)), nil)
                    return
            }
            if let data = data {
                do {
                    let cities = try JSONDecoder().decode(ImageModel.self, from: data)
                    completionhandler(nil, cities.hits)
                } catch {
                    completionhandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}


