//
//  ResultAfterOKVC.swift
//  DdoDdo-iOS
//
//  Created by 이주혁 on 2020/06/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ResultAfterOKVC: UIViewController {
    
    @IBOutlet var memberCollectionView: UICollectionView!
    @IBOutlet var missionTableView: UITableView!
    
    
    var data = ["이주혁", "김주혁", "이주혁", "김주혁", "김주혁", "김주혁"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memberCollectionView.dataSource = self
        self.memberCollectionView.delegate = self
        
        self.missionTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
}


extension ResultAfterOKVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultAfterOKMemberCell.identifier, for: indexPath) as? ResultAfterOKMemberCell {
            cell.nameLabel.text = self.data[indexPath.item]
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    
}

extension ResultAfterOKVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
