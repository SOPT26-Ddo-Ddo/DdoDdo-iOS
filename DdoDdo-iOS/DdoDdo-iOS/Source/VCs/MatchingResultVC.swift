//
//  MatchingResultVC.swift
//  DdoDdo-iOS
//
//  Created by 이주혁 on 2020/06/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class MatchingResultVC: UIViewController {

    @IBOutlet var favoriteCollectionView: UICollectionView!
    @IBOutlet var okButton: UIButton!
    
    @IBOutlet var infoBgView: UIView!
    @IBOutlet var keywordArray: [UILabel]!
    var favoriteList = ["#관심", "#관심", "#관심", "#관심"]
    var imageList = ["favorite-image-example1", "favorite-image-example2", "favorite-image-example3", "favorite-image-example4"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.okButton.layer.cornerRadius = 24
        self.okButton.layer.masksToBounds = true
        
        keywordArray.forEach { $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        self.infoBgView.layer.cornerRadius = 30
        self.infoBgView.clipsToBounds = true
        self.infoBgView.layer.maskedCorners = [.layerMaxXMinYCorner]

        self.infoBgView.dropShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
                                   offSet: CGSize(width: 0, height: -3), opacity: 0.11, radius: 10)
        
        self.favoriteCollectionView.dataSource = self
        self.favoriteCollectionView.delegate = self
    }
    
}

extension MatchingResultVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MatchingResultFavoriteCell.identifier, for: indexPath) as? MatchingResultFavoriteCell {
            cell.favoriteLabel.text = self.favoriteList[indexPath.item]
            cell.favoriteImageView.image = UIImage(named: self.imageList[indexPath.item])
            return cell
        }
        else {
            return UICollectionViewCell()
        }
        
    }
    
    
}
extension MatchingResultVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.height)
    }
}

