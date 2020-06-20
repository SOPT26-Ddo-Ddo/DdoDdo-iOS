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
    
    private var groupInfoData:groupDetailInfo?
    
    var groupIdx:Int?

    @IBAction func backButton(_ sender: Any) { self.navigationController?.popViewController(animated: true)}

    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var groupNameLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var numPeopleLabel: UILabel!
    @IBOutlet var deadLineLabel: UILabel!
    @IBOutlet var matchingBtn: UIButton!
    
    var collectionItems : [groupUserData] = []
    var groupName: String?
    var ImageItems = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        matchingBtn.layer.cornerRadius = 24
        self.view.backgroundColor = UIColor.paleGold
        collectionView.backgroundColor = UIColor.paleGold
        matchingBtn.backgroundColor = UIColor.paleGold
        setImgItems()
        networking()
        
   

    }
    
    
    
    func setImgItems(){
        ImageItems = ["profile-example4","profile-example7","sangil-profile","profile-example1","profile-example5","profile-example6","profile-example7","profile-example8"]
    }
    
               
           
        
        
        
    

    @IBAction func backBtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    @IBAction func matchBtn(_ sender: UIButton) {

        let matchingStoryboard = UIStoryboard.init(name: "MatchingResult", bundle: nil)
        
        if let dvc1 = matchingStoryboard.instantiateViewController(identifier: "MatchingResult") as? MatchingResultVC {
            dvc1.groupIdx = self.groupIdx
            dvc1.setLayout()
            
            dvc1.modalPresentationStyle = .fullScreen
            self.present(dvc1 , animated: true, completion: {
                let sb = UIStoryboard.init(name: "ResultAfterOK", bundle: nil)
                
                if let dvc2 = sb.instantiateViewController(identifier: "ResultAfterOK") as? ResultAfterOKVC {
                    dvc2.name = dvc1.myManitoInfo?.name
                    dvc2.msg = dvc1.myManitoInfo?.profileMsg
            
                    print(#function)
                    self.navigationController?.pushViewController(dvc2, animated: true)
                    
                }
            })
            

        }
        
        
//        SelectedGroupService.shared.GroupSelect() {
//            networkResult in switch networkResult {
//            case .success(let token):
//                guard let token = token as? String else { return }
//                UserDefaults.standard.set(token, forKey: "token")
//            case .requestErr(let message):
//                    guard let message = message as? String else { return }
//                print(message)
//
//            case .pathErr: print("path")
//            case .serverErr: print("serverErr")
//            case .networkFail: print("networkFail") }
//        }
//
       
    
    }

}
    

extension SelectedGroupViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedGroupProfileCell", for: indexPath) as? SelectedGroupProfileViewCell else { return UICollectionViewCell() }
        print(collectionItems[indexPath.item])
        cell.bind(model:collectionItems[indexPath.item])
        cell.profileImageView.image = UIImage(named: ImageItems[indexPath.row])
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.bounds.width / 2
        cell.profileImageView.contentMode = .scaleAspectFill
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



extension SelectedGroupViewController{
    func networking(){
        SelectedGroupService.groupShared.GroupSelect(idx:groupIdx!) { networkResult in
            switch networkResult {
            case .success(let token):
                guard let data = token as? DataInfo else {
                    return
                }
                
                self.collectionItems = data.groupUser!
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
                self.groupNameLabel.text = data.groupInfo?.name
                
                
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "그룹 정보 가져오기 실패", message: message, preferredStyle: .alert)
            case .pathErr:
                print("path")
            case .serverErr:
                 print("serverErr")
            case .networkFail:
                print("networkFail")
            }
                
            
        }
        
    }
}
