//
//  weatherAPIClient.swift
//  WeatherApp
//
//  Created by Oniel Rosario on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


final class elementAPIClient {
    static func getElements(completionHandler: @escaping (AppError?, [Weather]?) -> Void) {
        NetworkHelper.shared.performDataTask(endpointURLString: "MyUrl.GetElements", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
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
                    _ = try JSONDecoder().decode([Weather].self, from: data)
                    
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}


