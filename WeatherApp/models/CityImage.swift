//
//  cityImage.swift
//  WeatherApp
//
//  Created by Oniel Rosario on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


struct ImageModel: Codable {
    let hits: [Image]
}

struct Image: Codable {
    let largeImageURL: String
    let tags: String
    let user: String
    let favorites: Int
}
