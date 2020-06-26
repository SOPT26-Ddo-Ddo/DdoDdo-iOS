//
//  ResultAfterOKMissionCell.swift
//  DdoDdo-iOS
//
//  Created by 이주혁 on 2020/06/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class ResultAfterOKMissionCell: UITableViewCell {
    static let identifier = "ResultAfterOKMissionCell"
    @IBOutlet weak var missionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func touchUpCheckButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}
