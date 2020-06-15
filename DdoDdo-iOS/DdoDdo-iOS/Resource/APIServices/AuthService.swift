//
//  AuthService.swift
//  DdoDdo-iOS
//
//  Created by 이주혁 on 2020/06/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct AuthService {
    static let shared = AuthService()
    
    func login(id: String, pw: String){
        
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let body: Parameters = [
            "id" : id,
            "pwd": pw
        ]
        
        Alamofire.request(APIConstants.loginURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let value = response.result.value else {
                    return
                }
                print(statusCode)
            case .failure(let err):
                print(err.localizedDescription)

            }
        }
    }
    
    private func isCorrectUser(statusCode: Int, data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200..<300:
            return .success(<#T##Any#>)
        case 300..<400:
            return .pathErr
        case 400..<500:
            return .requestErr("로그인 실패")
        default:
            break
        }
        
        return .networkFail
    }
}
