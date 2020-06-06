//
//  HomeVC.swift
//  DdoDdo-iOS
//
//  Created by 이예슬 on 6/7/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    private var testData:[[String]] = []
    var userName :String = "이예슬"
    var profileData: ProfileData?
    @IBOutlet weak var topSearchButton: UIButton!
    
    @IBOutlet weak var homeProfileHiLabel: UILabel!
    @IBOutlet weak var homeProfileImageView: UIImageView!
    @IBAction func changeProfileImageBtn(_ sender: Any) {
    }
    @IBOutlet weak var homeProfileTextView: UITextView!
    @IBOutlet weak var groupTableView: UITableView!
    @IBAction func addGroupButton(_ sender: Any) {
    }
    @IBOutlet weak var addGroup: UIButton!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.paleGold
        super.viewDidLoad()
        groupTableView.delegate = self
        groupTableView.dataSource = self
        setData()
        setHiLabel()
        addGroup.backgroundColor = UIColor.paleGold
        addGroup.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }
    private func setData(){
        testData = [["버디버디4조","디자인어쩌구"],["아요","화이팅"]]
        HomeService.shared.loadHome { networkResult in
            switch networkResult{
            case .success(let data):
                guard let pdata = data as? ProfileData else {
                    return
                }
                self.profileData = pdata
                print(self.profileData ?? "")
            case .requestErr(let msg):
                print(msg)
            case .networkFail:
                break
            case .pathErr:
                break
            case .serverErr:
                break
            default:
                break
            }
        }
        
    }
    private func setHiLabel(){
        homeProfileHiLabel.text = "\(userName)님 안녕하세요!"
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
        return testData[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let groupCell = tableView.dequeueReusableCell(withIdentifier: HomeGroupCell.identifier) as? HomeGroupCell else {return UITableViewCell()}
        groupCell.setGroupName(groupName: testData[indexPath.section][indexPath.row])
        
        return groupCell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return testData.count
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
            if let dvc = sb.instantiateViewController(identifier: "SelectedGroupVC") as? SelectedGroupViewController { self.navigationController?.pushViewController(dvc, animated: true)
            }
        case 1:
            let sb = UIStoryboard.init(name: "ManitoCheck", bundle: nil)
            if let dvc = sb.instantiateViewController(identifier: "ManitoCheckVC") as? ManitoCheckVC {
                self.navigationController?.pushViewController(dvc, animated: true)
            }
        default:
            break
        }
        
    }

}
