//
//  HomeService.swift
//  DdoDdo-iOS
//
//  Created by 이예슬 on 6/7/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import Alamofire


struct HomeService{
    static let shared = HomeService()
    func loadHome(completion: @escaping (NetworkResult<Any>)-> Void){
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let header: HTTPHeaders = ["Content-Type":"application/json","token":token]
        let dataRequest = Alamofire.request(APIConstants.homeURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData{
            response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {return}
                guard let value = response.result.value else {return}
                let networkResult = self.judge(by: statusCode, value)
                completion(networkResult)
            case .failure: completion(.networkFail)
            }
        }
    }
    
    
    private func judge(by statusCode:Int, _ data:Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            return decodingHome(by : data)
        case 400:
            return .pathErr
        case 500:
            return .serverErr
        default: return .networkFail
        }
    }
    private func decodingHome(by data:Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(HomeData.self, from: data) else
        {return .pathErr}
        guard let homeInfo = decodedData.data else {
            //print("여기")
            return .requestErr(decodedData.message)}
        return .success(homeInfo)
    }
}

