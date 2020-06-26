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
//    private func makeParameter(_ id:String, _ pwd:String, _ name:String, _ gender:String, _ profileMsg:String, _ profileImgName:String, _ profileImg:UIImage) -> Parameters {
//        return ["id":id, "password": pwd, "name":name, "gender":gender,"profileMsg":profileMsg]
//    }//Request Body에들어갈parameter 생성
    func signup(id: String, pwd: String,name:String,gender:String,profileMsg:String,profileImgName:String,profileImg:UIImage, completion: @escaping (NetworkResult<Any>) -> Void){
        
        let header: HTTPHeaders = ["Content-Type": "multipart/form-data"]
        
        let body: Parameters = [
            "id" : id,
            "pwd": pwd,
            "name" :name,
            "gender":gender,
            "profileMsg":profileMsg
        ]
        Alamofire.upload(multipartFormData : {multipartFormData in
            for(key,value) in body{
                let val = value as! String
                multipartFormData.append(val.data(using:String.Encoding.utf8)!,withName:key)
            }
            let imageData = profileImg.jpegData(compressionQuality:1.0)!
            multipartFormData.append(imageData,withName:"profileImg", fileName:profileImgName, mimeType:"image/jpeg")
        }, usingThreshold:UInt64.init(), to: APIConstants.signupURL,method:.post, headers:header,encodingCompletion:{(result) in
            switch result{
            case .success(let upload,_,_):
                upload.uploadProgress(closure: { (progress) in
                    print(progress.fractionCompleted) })
                upload.responseData { response in
                    guard let statusCode = response.response?.statusCode, let data = response.result.value else { return }
                    let networkResult = self.judge(statusCode, data)
                    completion(networkResult)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.networkFail) }
        })
        
    }
    private func judge(_ statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isUpdating(data)
        case 400: return .pathErr
        case 500: return .serverErr default: return .networkFail }
    }
    
    
    private func isUpdating(_ data:  Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(GenericResponse<SignupData>.self, from: data) else { return .pathErr }
        if decodeData.status == 200 {
            guard let userData = decodeData.data else { return .requestErr(decodeData.message) }
            return .success(userData.userID) }
        else {
            return .requestErr(decodeData.message) }
    }
}

