//
//  userProfileApi.swift
//  Alforno
//
//  Created by Ahmed farid on 3/3/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class userProfileApi: NSObject {
    
    class func profile(completion: @escaping(_ error: Error?,_ networkSuccess: Bool,_ codeSucess: Bool ,_ userProfiles: userProfile?)-> Void){
       
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,false,nil)
            return
        }
        
        let parametars = [
            "lang": "en"
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        let url = URLs.userProfile
        print(url)
        print(parametars)
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let userProfiles = try JSONDecoder().decode(userProfile.self, from: response.data!)
                    if userProfiles.status == false {
                        completion(nil,true,true,userProfiles)
                    }else {
                        completion(nil,true,true,userProfiles)
                    }
                }catch{
                    print("error")
                    completion(nil,true,false,nil)
                }
            }
        }
    }
    
    class func upadateProfile(name: String, phone: String,email: String,completion: @escaping(_ error: Error?,_ networkSuccess: Bool,_ codeSucess: Bool ,_ upadteProfiles: editProfiel?)-> Void){
       
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,false,nil)
            return
        }
        
        let parametars = [
            "lang": "en",
            "name":name,
            "phone": phone,
            "email": email
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        let url = URLs.updateProfile
        print(url)
        print(parametars)
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let userProfiles = try JSONDecoder().decode(editProfiel.self, from: response.data!)
                    if userProfiles.status == false {
                        completion(nil,true,true,userProfiles)
                    }else {
                        completion(nil,true,true,userProfiles)
                    }
                }catch{
                    print("error")
                    completion(nil,true,false,nil)
                }
            }
        }
    }
}
