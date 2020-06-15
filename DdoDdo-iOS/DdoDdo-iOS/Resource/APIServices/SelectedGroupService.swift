//
//  SelectedGroupService.swift
//  DdoDdo-iOS
//
//  Created by 황지은 on 2020/06/07.
//  Copyright © 2020 이주혁. All rights reserved.
//
import Foundation
import Alamofire


struct SelectedGroupService {
    static let groupShared = SelectedGroupService()
   
//    private func makeParameter(_ groupIdx: Int) -> Parameters { return ["groupIdx": groupIdx]
//    }
    
    func GroupSelect(idx:Int, completion: @escaping ( NetworkResult<Any>) -> Void ) {
      

        let header: HTTPHeaders = ["Content-Type":"application/json"]
        let dataRequest = Alamofire.request(APIConstants.SelectedGroupURL + "\(idx)" ,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
           
        
        dataRequest.responseData { dataResponse in
           switch dataResponse.result {
           case .success:
            guard let statusCode = dataResponse.response?.statusCode else {return}
            guard let value = dataResponse.result.value else {return}
            
            let networkResult = self.judge(by: statusCode, value as! Data)
            print(statusCode)
            completion(networkResult)
           
           case .failure: completion(.networkFail)
            }
            
        }
           
    }
            private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> { switch statusCode {
            case 200: return isGroupExist(by: data)
            case 400: return .pathErr
            case 500: return .serverErr
            default: return .networkFail }
           
    }
           
    private func isGroupExist(by data: Data) -> NetworkResult<Any> {
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(SelectedGroupData.self, from: data) else {
                return .pathErr
                
        }
        guard let tokenData = decodedData.data else {
            return .requestErr(decodedData.message)
            
        }
        return .success(tokenData)
            
    }
    
}


