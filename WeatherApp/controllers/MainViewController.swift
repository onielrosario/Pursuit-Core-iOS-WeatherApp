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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backGroundImage.loadGif(name: "wathBackground")
        
    }
    
    
    
    
    
}

