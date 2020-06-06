//
//  SelectedGroupData.swift
//  DdoDdo-iOS
//
//  Created by 황지은 on 2020/06/07.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct SelectedGroupData: Codable {
    
    var status: Int
    var success: Bool
    var message: String
    var data: DataInfo?
    
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
           data = (try? values.decode(DataInfo.self, forKey: .data)) ?? nil
       }
}


struct DataInfo: Codable {
    var groupInfo: groupDetailInfo?
    var groupUser: [groupUserData]?
    
    enum CodingKeys: String, CodingKey {
          case groupInfo = "groupInfo"
          case groupUser = "groupUser"
      }
      
      init(from decoder: Decoder) throws {
             let values = try decoder.container(keyedBy: CodingKeys.self)
             
             groupInfo = (try? values.decode(groupDetailInfo.self, forKey: .groupInfo)) ?? nil
             groupUser = (try? values.decode([groupUserData].self, forKey: .groupUser)) ?? nil
         }
    
}


struct groupDetailInfo: Codable {
    var groupIdx:Int
    var groupPwd:Int
    var name:String
    var numPeople:Int
    var deadLine:String
    var fix:Int
    var finish:Int
    var leader:Int
}


struct groupUserData: Codable {
    var userIdx:Int
    var id:String
    var pwd:String
    var name:String
    var gender:String
    var profileMsg:String
}
