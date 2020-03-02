//
//  favoriteAPI.swift
//  Alforno
//
//  Created by Ahmed farid on 3/2/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class favoriteAPI: NSObject {
    
    class func add(product_id: String,completion: @escaping(_ error: Error?,_ success: Bool,_ fav: addTofav?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "lang": "en",
            "product_id": product_id
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        let url = URLs.addToFavorits
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
                    let addFov = try JSONDecoder().decode(addTofav.self, from: response.data!)
                    if addFov.status == false {
                        completion(nil,true,addFov)
                    }else {
                        completion(nil,true,addFov)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
    
    
    class func allProducts(completion: @escaping(_ error: Error?,_ success: Bool,_ favProducts: Offers?)-> Void){
       
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "lang": "en"
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        let url = URLs.listFavoriteProduct
        print(url)
        print(parametars)
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let favProducts = try JSONDecoder().decode(Offers.self, from: response.data!)
                    if favProducts.status == false {
                        completion(nil,true,favProducts)
                    }else {
                        completion(nil,true,favProducts)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
}
