//
//  SignupService.swift
//  DdoDdo-iOS
//
//  Created by 이예슬 on 6/24/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire

struct SignupService {
    static let shared = SignupService()
    private func makeParameter(_ id:String, _ pwd:String, _ name:String, _ gender:String, _ profileMsg:String) -> Parameters {
        return ["id":id, "password": pwd, "name":name, "gender":gender,"profileMsg":profileMsg]
    }//Request Body에들어갈parameter 생성
    func signup(id: String, pwd: String,name:String,gender:String,profileMsg:String, completion: @escaping (NetworkResult<Any>) -> Void){
        
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let body: Parameters = [
            "id" : id,
            "pwd": pwd,
            "name" :name,
            "gender":gender,
            "profileMsg":profileMsg
        ]
        
        Alamofire.request(APIConstants.signupURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseData { response in
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
        guard let decodedData = try? decoder.decode(GenericResponse<SignupData>.self, from: data) else {
            return .pathErr
        }
        guard let userData = decodedData.data else {
            return .requestErr(decodedData.message)
        }
        
        switch statusCode {
        case 200..<300:
            return .success(userData.userID)
        case 300..<400:
            return .pathErr
        case 400..<500:
            return .requestErr(decodedData.message)
        default:
            return .pathErr
        }
    
    }
}
