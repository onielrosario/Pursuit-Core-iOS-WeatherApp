//
//  FavoriteViewController.swift
//  WeatherApp
//
//  Created by Oniel Rosario on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var favoriteBackground: UIImageView!
    private var favoriteimages = [Favorite]() {
        didSet {
     self.collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
    favoriteBackground.loadGif(name: "cities")
        cityImageHelper.getImages()
    self.favoriteimages = cityImageHelper.favoriteImages
    }
}

extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteimages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? FavoriteCollectionViewCell else { return UICollectionViewCell() }
       let cellImage = favoriteimages[indexPath.row]
        cell.favoriteImage.image = UIImage.init(data: cellImage.imageData)
        return cell
    }
    
    
}
