//
//  CityModel.swift
//  WeatherApp
//
//  Created by Oniel Rosario on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class cityImageHelper {
    public static let filename = "PhotojournalList.plist"
    private static var images = [Image]()
    private init() {}
    static func savePhoto() {
        let path = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(images)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list error: \(error)")
        }
    }
    
    static func getImages() {
        let pathString = DataPersistenceManager.filePathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: pathString) {
            if let data = FileManager.default.contents(atPath: pathString) {
            do {
                images = try PropertyListDecoder().decode([Image].self, from: data)
            } catch {
                print("property list deocoding error: \(error)")
            }
            } else {
                print("could not find data")
            }
        } else {
            print("\(filename) could not be located")
        }
    }
    static func addPhoto(image: Image) {
        images.append(image)
        savePhoto()
    }
    static func deletePhoto(atIndex index: Int) {
        images.remove(at: index)
        savePhoto()
    }
    
    static func editPhoto(image: Image, atIndex index: Int) {
        images[index] = image
        savePhoto()
    }
}
