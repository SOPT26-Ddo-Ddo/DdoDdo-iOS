//
//  HomeData.swift
//  DdoDdo-iOS
//
//  Created by 이예슬 on 6/7/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct HomeData: Codable {
    var status: Int
    var success: Bool
    var message: String
    var data: ProfileData?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
    }
     
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(Int.self, forKey: .status)) ?? -1
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(ProfileData.self, forKey: .data)) ?? nil
    }
}
struct ProfileData: Codable{
    var idx: Int
    var name: String
    var profileMsg: String
    var profileImg: String?
    var groupOn: [GroupInfo]
    var groupOff: [GroupInfo]
}
struct GroupInfo: Codable{
    var groupIdx: Int
    var name: String
    var numPeople:Int
    var deadline:String
    var fix:Int
    var finish:Int
    var leader:Int
}


