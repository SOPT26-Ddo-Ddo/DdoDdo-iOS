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
    
    func login(id: String, pw: String, completion: @escaping (NetworkResult<Any>) -> Void){
        
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
                completion(self.isCorrectUser(statusCode: statusCode, data: value))
            case .failure(let err):
                print(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func isCorrectUser(statusCode: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(LoginData.self, from: data) else {
            return .pathErr
        }
        guard let tokenData = decodedData.data else {
            return .requestErr(decodedData.message)
        }
        
        switch statusCode {
        case 200..<300:
            return .success(tokenData.accessToken)
        case 300..<400:
            return .pathErr
        case 400..<500:
            return .requestErr(decodedData.message)
        default:
            return .pathErr
        }
    
    }
}
