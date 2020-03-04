//
//  cartApi.swift
//  Alforno
//
//  Created by Ahmed farid on 3/4/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class cartApi: NSObject {
    
    class func addCarts(product_id: String,product_quantity: String,size_id: String,addition_id: String, completion: @escaping(_ error: Error?,_ success: Bool,_ message: addCart?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "product_id": product_id,
            "product_quantity": product_quantity,
            "size_id": size_id,
            "addition_id": addition_id
            ] as [String : Any]
        
        
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user_token)"
        ]
        
        let url = URLs.addCart
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let message = try JSONDecoder().decode(addCart.self, from: response.data!)
                    if message.status == false {
                        completion(nil,true,message)
                    }else {
                        completion(nil,true,message)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
}
