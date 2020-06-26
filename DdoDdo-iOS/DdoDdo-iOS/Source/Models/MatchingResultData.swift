//
//  MatchingResultData.swift
//  DdoDdo-iOS
//
//  Created by 이예슬 on 6/18/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation

struct ManitoData: Codable {
    var status: Int
    var success: Bool
    var message: String?
    var data: MatchingResult?
    
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
           message = (try? values.decode(String.self,forKey: .message)) ?? ""
           data = (try? values.decode(MatchingResult.self, forKey: .data)) ?? nil
    }
}

// MARK: - DataClass
struct MatchingResult: Codable {
    var myManito: MyManito
}

// MARK: - MyManito
struct MyManito: Codable {
    var userIdx: Int
    var id, pwd, salt, name: String
    var gender, profileMsg: String
    var profileImg : String
    
}
