//
//  Weather.swift
//  WeatherApp
//
//  Created by Oniel Rosario on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


struct Weather: Codable {
    let response: [Response]
}

struct Response: Codable {
    let loc: Location?
    let interval: String?
    let periods: [Period]
    let profile: Profile
}

struct Location: Codable {
    let long: Double
    let lat: Double
}

//Additional information about the weather including the high, low, sunrise, sunset, windspeed and precipitation
struct Period: Codable {
    let validTime: String
    let dateTimeISO: String
    let maxTempF: Int
    let minTempF: Int
    let humidity: Int
    let feelslikeF: Int
    let windDir: String
    let windSpeedMPH: Int
    let weather: String
    let icon: String
    let sunriseISO: String
    let sunsetISO: String
    
}

struct Profile: Codable {
    let tz: String
}
