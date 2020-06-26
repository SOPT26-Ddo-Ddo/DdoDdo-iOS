//
//  ProfileUploadData.swift
//  DdoDdo-iOS
//
//  Created by 이예슬 on 6/26/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation


// MARK: - Datum
struct ProfileUploadData: Codable {
    var id, name, profileMsg: String
    var profileImg: String?
}
