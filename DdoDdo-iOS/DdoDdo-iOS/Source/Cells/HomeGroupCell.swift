//
//  HomeGroupCell.swift
//  DdoDdo-iOS
//
//  Created by 이예슬 on 6/7/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class HomeGroupCell: UITableViewCell {
    static let identifier: String = "HomeGroupCell"
    @IBOutlet weak var groupName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setGroupName(groupName: String){
        self.groupName.text = groupName
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
