//
//  SelectedGroupViewController.swift
//  DdoDdo-iOS
//
//  Created by 황지은 on 2020/06/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit
import Alamofire

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
        matchingBtn.backgroundColor = UIColor.paleGold
        setImgItems()

    }
    
    func setCollectionItems() {
            collectionItems = [
                "안유경",
                "최상일",
                "최선아",
                "이예슬",
                "김민지",
                "이주혁",
                "황지은",
                "김보배"
            ]
        }
    
    func setImgItems(){
        ImageItems = ["profile-example1","profile-example2","profile-example3","profile-example4","profile-example5","profile-example6","profile-example7","profile-example8"]
    }
    
    func setData(){
        groupNameLabel.text = "아요 왕초보반 스터디"
        
        
    }

    @IBAction func matchBtn(_ sender: UIButton) {
        
        SelectedGroupService.shared.GroupSelect() {
            networkResult in switch networkResult {
            case .success(let token):
                guard let token = token as? groupDetailInfo else { return }
                self.numPeopleLabel.text = "\(token.numPeople)"
                UserDefaults.standard.set(token, forKey: "token")
            case .requestErr(let message):
                    guard let message = message as? String else { return }
                print(message)
                    
            case .pathErr: print("path")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail") }
        }
        
       
    
    }

}

extension SelectedGroupViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedGroupProfileCell", for: indexPath) as? SelectedGroupProfileViewCell else { return UICollectionViewCell() }
                
        cell.profileNameLabel.text = collectionItems[indexPath.row]
        cell.profileImageView.image = UIImage(named: ImageItems[indexPath.row])
        
        cell.profileStatusBtn.layer.cornerRadius = 9
      
        cell.profileStatusBtn.isHidden = true
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
