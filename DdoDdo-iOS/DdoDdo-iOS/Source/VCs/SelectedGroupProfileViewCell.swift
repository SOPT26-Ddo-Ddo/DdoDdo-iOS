//
//  SelectedGroupProfileViewCell.swift
//  DdoDdo-iOS
//
//  Created by 황지은 on 2020/06/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SelectedGroupProfileViewCell: UICollectionViewCell {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileStatusBtn: UIButton!
    
    
//
//       func bind (model:DataInfo){
//        guard let nameURL = URL(string: model.groupInfo!.name) else { return }
//
//
//
//             profileNameLabel.text = model.groupInfo?.name
//
//                  do {
//                      let data = try Data(contentsOf: nameURL)
//                    profileNameLabel.text = "\(data)"
//
//                  } catch (let err) {
//                      print(err.localizedDescription)
//                  }
//
//       }
    
    func bind (model:groupUserData){
     
//        guard let userNameURL = URL(string: model.name) else { return }
        print(#function)
               
       
        profileNameLabel.text = model.name
       
//
//               do {
//                   let data = try Data(contentsOf: userNameURL)
//                     profileNameLabel.text = "\(data)"
//               } catch (let err) {
//                   print(err.localizedDescription)
//               }

    }
    
}



