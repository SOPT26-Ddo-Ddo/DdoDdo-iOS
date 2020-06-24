//
//  SignupData.swift
//  DdoDdo-iOS
//
//  Created by 이예슬 on 6/24/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct SignupData: Codable {
    var userID: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
    }
}
