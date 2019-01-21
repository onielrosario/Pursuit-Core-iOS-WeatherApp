//
//  DataPersistenceManager.swift
//  WeatherApp
//
//  Created by Oniel Rosario on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation


final class DataPersistenceManager {
    static func DocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    
    static func filePathToDocumentsDirectory(filename: String) -> URL {
        return DocumentsDirectory().appendingPathComponent(filename)
    }
}
