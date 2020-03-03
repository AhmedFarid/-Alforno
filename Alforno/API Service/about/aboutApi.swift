//
//  aboutApi.swift
//  Alforno
//
//  Created by Ahmed farid on 3/3/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class aboutApi: NSObject {
    
    class func aboutApi(completion: @escaping(_ error: Error?,_ success: Bool,_ codeSucess: Bool,_ about: About?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,false,nil)
            return
        }
        
        let parametars = [
            "lang": "en",
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        let url = URLs.about
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let about = try JSONDecoder().decode(About.self, from: response.data!)
                    if about.status == false {
                        completion(nil,true,true,about)
                    }else {
                        completion(nil,true,true,about)
                    }
                }catch{
                    print("error")
                    completion(nil,true,false,nil)
                }
            }
        }
    }
}
