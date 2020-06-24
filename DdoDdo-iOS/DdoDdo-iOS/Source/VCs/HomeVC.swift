//
//  HomeVC.swift
//  DdoDdo-iOS
//
//  Created by 이예슬 on 6/7/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    private var homeUserData:ProfileData?
    //private var testData:[[String]] = []
    //var userName :String = "안유경"
    @IBOutlet weak var topSearchButton: UIButton!
    
    @IBOutlet weak var homeProfileHiLabel: UILabel!
    @IBOutlet weak var homeProfileImageView: UIImageView!
    @IBAction func changeProfileImageBtn(_ sender: Any) {
    }
    @IBOutlet weak var homeProfileTextView: UITextView!
    @IBOutlet weak var groupTableView: UITableView!
    @IBAction func addGroupButton(_ sender: Any) {
    }
    @IBAction func logout(_ sender: Any) {
        self.dismiss(animated:true)
        
    }
    @IBOutlet weak var addGroup: UIButton!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.paleGold
        self.addGroup.dropShadow(color: .black, offSet: CGSize(width: 0, height: 3), opacity: 0.16, radius: 6)
        super.viewDidLoad()
        self.homeProfileImageView.layer.cornerRadius = self.homeProfileImageView.bounds.width/2
        HomeService.shared.loadHome(){ networkResult in
            switch networkResult{
            case .success(let homeData):
                print(homeData)
                guard let homedata = homeData as? ProfileData else{return}
                self.homeUserData = homedata
                DispatchQueue.main.async {
                    self.groupTableView.reloadData()
                    self.setProfileLabel()
                    self.setProfileImg(homedata.idx)
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
            
        
   
        groupTableView.delegate = self
        groupTableView.dataSource = self
        //setData()
        
        addGroup.backgroundColor = UIColor.paleGold
        addGroup.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }
    
    private func setProfileLabel(){
        homeProfileHiLabel.text = homeUserData?.name ?? ""
        homeProfileTextView.text = homeUserData?.profileMsg ?? ""
    }
    private func setProfileImg(_ userIdx: Int){
        switch userIdx {
        case 48:
            homeProfileImageView.image = UIImage(named:"profile-example4")
        case 49:
            homeProfileImageView.image = UIImage(named:"profile-example7")
        case 50:
            homeProfileImageView.image = UIImage(named:"profile-example8")
        default:
            homeProfileImageView.image = UIImage(named:"AppIcon")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            
            return homeUserData?.groupOn.count ?? 0
        }
        else{
            return homeUserData?.groupOff.count ?? 0
        }
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let groupCell = tableView.dequeueReusableCell(withIdentifier: HomeGroupCell.identifier) as? HomeGroupCell else {return UITableViewCell()}
        groupCell.groupName.text = homeUserData?.groupOn[indexPath.row].name
        
        return groupCell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 20, y:18, width: 100, height: 26)
        headerLabel.font = UIFont.systemFont(ofSize: CGFloat(17),weight: .bold)
        let headerView = UIView()
        
        
        if section==0{
            headerLabel.text = "나의 마니또"
            headerView.addSubview(headerLabel)
            return headerView
        }
        else if section==1{
            headerLabel.text = "완료된 마니또"
            headerView.addSubview(headerLabel)
            return headerView
        }
        else{
            return UIView()
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var headerTitle : String?
//        if (section == 0){
//            headerTitle = "내 마니또"
//            return headerTitle        }
//        else{
//            headerTitle = "완료된 마니또"
//            return headerTitle
//        }
//    }
}

extension HomeVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let sb = UIStoryboard.init(name: "SelectedGroup", bundle: nil)
            if let dvc = sb.instantiateViewController(identifier: "SelectedGroupVC") as? SelectedGroupViewController {
                dvc.groupIdx = homeUserData?.groupOn[indexPath.row].groupIdx
                self.navigationController?.pushViewController(dvc, animated: true)
            }
        case 1:
            let sb = UIStoryboard.init(name: "ManitoCheck", bundle: nil)
            if let dvc = sb.instantiateViewController(identifier: "ManitoCheckVC") as? ManitoCheckVC {
               // dvc.groupIdx = homeUserData?.groupOff[indexPath.row].groupIdx
                self.navigationController?.pushViewController(dvc, animated: true)
            }
        default:
            break
        }
        
    }

}
