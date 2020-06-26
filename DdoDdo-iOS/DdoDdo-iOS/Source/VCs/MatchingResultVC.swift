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
    @IBOutlet weak var bigProfile: UIImageView!
    @IBOutlet weak var manitoNameLabel: UILabel!
    @IBOutlet weak var manitoMsgLabel: UILabel!
    @IBAction func backButton(_ sender: Any) {
        
    }
    var myManitoInfo : MyManito?
    var favoriteList = ["#고기", "#돈스파이크", "#지민", "#기획"]
    var imageList = ["favorite-image-example1", "favorite-image-example2", "favorite-image-example3", "favorite-image-example4"]
    var bigProfileImg: String?
    var groupIdx:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        self.okButton.layer.cornerRadius = 24
        self.okButton.layer.masksToBounds = true
        
        keywordArray.forEach { $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        self.infoBgView.layer.cornerRadius = 30
        self.infoBgView.clipsToBounds = true
        // .layerMaxXMinYCorner : 오른쪽 위
        // .layerMaxXMaxYCorner : 오른쪽 아래
        // .layerMinXMaxYCorner : 왼쪽 아래
        // .layerMinXMinYCorner : 왼쪽 위
        self.infoBgView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner ,.layerMinXMaxYCorner, .layerMinXMinYCorner]

        self.infoBgView.dropShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
                                   offSet: CGSize(width: 0, height: -3), opacity: 0.11, radius: 10)
        
        self.favoriteCollectionView.dataSource = self
        self.favoriteCollectionView.delegate = self
        
    }
    
    func setLayout(){
        MatchingResultService.shared.loadMyManito(groupIdx!){ networkResult in
                switch networkResult{
                case .success(let manitoData):
                    print(manitoData)
                    guard let manitodata = manitoData as? MatchingResult else{return}
                    self.myManitoInfo = manitodata.myManito
              
                    switch self.myManitoInfo!.userIdx{
                    case 48:
                        self.bigProfileImg = "profile-example4"
                    case 49:
                        self.bigProfileImg = "profile-example7"
                    case 51:
                        self.bigProfileImg = "sangil-profile"
                    default:
                        break
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.bigProfile.image = UIImage(named:self.bigProfileImg ?? "")
                        self.manitoNameLabel.text = self.myManitoInfo?.name
                        self.manitoMsgLabel.text = self.myManitoInfo?.profileMsg
                    }
                case .requestErr(let message):
                    guard let message = message as? String else {return}
                    print(message)
                case .serverErr: print("serverErr")
                case .pathErr:
                    print("pathErr")
                case .networkFail:
                    print("networkFail")
                }
                    
        }
    }
    
    @IBAction func touchUpOKButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: {
            
        })
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

