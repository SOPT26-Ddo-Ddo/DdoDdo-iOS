//
//  SelectedGroupViewController.swift
//  DdoDdo-iOS
//
//  Created by 황지은 on 2020/06/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SelectedGroupViewController: UIViewController {
    

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var groupNameLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var numPeopleLabel: UILabel!
    @IBOutlet var deadLineLabel: UILabel!
    @IBOutlet var matchingBtn: UIButton!
    
    var collectionItems = [String]()
    var ImageItems = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        setCollectionItems()
        matchingBtn.layer.cornerRadius = 24
        setData()
        self.view.backgroundColor = UIColor.paleGold
        collectionView.backgroundColor = UIColor.paleGold

    }
    
    func setCollectionItems() {
            collectionItems = [
                "황지은",
                "이예슬",
                "이주혁",
                "최상일",
                "김민지",
                "김보배",
                "최선아",
                "안유경"
            ]
        }
    
    func setImgItems(){
        ImageItems = ["","","","","","","","",""]
    }
    
    func setData(){
        groupNameLabel.text = "아요 왕초보반 스터디"
        
        
    }

    @IBAction func matchBtn(_ sender: UIButton) {
        
    }
    

}

extension SelectedGroupViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedGroupProfileCell", for: indexPath) as? SelectedGroupProfileViewCell else { return UICollectionViewCell() }
                
        cell.profileNameLabel.text = collectionItems[indexPath.row]
        
        cell.profileStatusBtn.layer.cornerRadius = 9
        //cell.profileStatusBtn.isHidden = true
        return cell
    }
    
    
}

extension SelectedGroupViewController:UICollectionViewDelegate {
    
    
    
    
}


extension SelectedGroupViewController:UICollectionViewDelegateFlowLayout {
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: 79, height: 103)
                
    }
    
}
