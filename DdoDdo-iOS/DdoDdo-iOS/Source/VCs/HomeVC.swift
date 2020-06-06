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
    @IBOutlet weak var topSearchButton: UIButton!
    
    @IBOutlet weak var homeProfileHiLabel: UILabel!
    @IBOutlet weak var homeProfileImageView: UIImageView!
    @IBOutlet weak var homeProfileTextView: UITextView!
    @IBOutlet weak var groupTableView: UITableView!
    @IBAction func addGroupButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.delegate = self
        groupTableView.dataSource = self
        setData()
        setHiLabel()
        // Do any additional setup after loading the view.
    }
    private func setData(){
        testData = [["버디버디4조","디자인어쩌구"],["아요","화이팅"]]
        
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
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerTitle : String?
        if (section == 0){
            headerTitle = "내 마니또"
            return headerTitle        }
        else if (section == 1){
            headerTitle = "완료된 마니또"
            return headerTitle
        }
    }
}

extension HomeVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }

}
