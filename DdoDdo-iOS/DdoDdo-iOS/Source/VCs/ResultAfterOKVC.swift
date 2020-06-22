//
//  ResultAfterOKVC.swift
//  DdoDdo-iOS
//
//  Created by 이주혁 on 2020/06/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ResultAfterOKVC: UIViewController {
    
    @IBOutlet weak var manitoLabel: UILabel!
    @IBOutlet var memberCollectionView: UICollectionView!
    @IBOutlet var missionTableView: UITableView!
    
    @IBOutlet var groupInfoBg: UIView!
    
    @IBOutlet var interestingLabelArray: [UILabel]!
    
    @IBOutlet var backToHomeButton: UIButton!
    @IBOutlet var naviBg: UIView!
    @IBOutlet weak var MyManitoProfileImg: UIImageView!
    @IBOutlet weak var manitoMsg: UILabel!
    var name :String?
    var msg :String?
    var manitoIdx:Int?
    var tagList = ["흥부자", "케이팝", "상큼한"]
    var imageList = ["profile-example1", "profile-example2", "profile-example3", "profile-example4", "profile-example5", "profile-example6", "profile-example7", "profile-example8"]
    var missionList = ["마음을 담은 손편지를 집으로 보내주세요.", "닮은 연예인을 찾아서 말해주세요.","먼저 연락을 해보세요.","몰래 칭찬해주세요."]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.groupInfoBg.backgroundColor = UIColor.paleGold
        self.view.backgroundColor = UIColor.paleGold
        self.naviBg.backgroundColor = UIColor.paleGold
        self.memberCollectionView.dataSource = self
        self.memberCollectionView.delegate = self
        
        self.missionTableView.dataSource = self
        // Do any additional setup after loading the view.
        self.interestingLabelArray.forEach {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        self.manitoLabel.text = self.name
        self.setMyManito(userIdx: self.manitoIdx)
        self.manitoMsg.text = self.msg
        
        self.backToHomeButton.backgroundColor = UIColor.paleGold
        self.backToHomeButton.layer.cornerRadius = 24
        //self.backToHomeButton.layer.masksToBounds = true
        self.backToHomeButton.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.16, radius: 6)
        
    }
    @IBAction func dismissButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backToHomeButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func changeImage(_ imageName :String){
        self.MyManitoProfileImg.image = UIImage(named:imageName)
        self.MyManitoProfileImg.layer.cornerRadius = self.MyManitoProfileImg.bounds.width / 2
        self.MyManitoProfileImg.contentMode = .scaleAspectFill
    }
    func setMyManito(userIdx manitoIdx :Int?){
        switch manitoIdx{
        case 48:
            changeImage("profile-example4")
        case 49:
            changeImage("profile-example7")
        case 51:
            changeImage("sangil-profile")
        default:
            break
        }
        //self.MyManitoProfileImg.image = 
    }
    
}


extension ResultAfterOKVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultAfterOKMemberCell.identifier, for: indexPath) as? ResultAfterOKMemberCell {
            cell.profileImageView.image = UIImage(named: self.imageList[indexPath.item])
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 12) / 8, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

extension ResultAfterOKVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.missionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ResultAfterOKMissionCell.identifier) as? ResultAfterOKMissionCell {
            cell.missionLabel.text = missionList[indexPath.row]
            return cell
        }
        else {
            return UITableViewCell()
        }
        
    }
    
    
}

