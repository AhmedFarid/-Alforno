//
//  loginApi.swift
//  Alforno
//
//  Created by Ahmed farid on 2/26/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Alamofire


class loginApi: NSObject {
    
    class func login(email: String,password: String, completion: @escaping(_ error: Error?,_ success: Bool, _ userData: Auth?)-> Void){
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        let url = URLs.login
        
        print(url)
        print(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let login = try JSONDecoder().decode(Auth.self, from: response.data!)
                    if login.status == false {
                        completion(nil,true,login)
                    }else {
                        helperLogin.saveAPIToken(token: login.data?.userToken ?? "")
                        completion(nil,true,login)
                    }
                }catch{
                    print("error")
                }
            }
        }
        
    }
    
}
