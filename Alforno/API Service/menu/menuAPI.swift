//
//  menuAPI.swift
//  Alforno
//
//  Created by Ahmed farid on 3/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class mnueApi: NSObject {
    
    class func mnue(completion: @escaping(_ error: Error?,_ success: Bool,_ cats: Categories?)-> Void){
        let parametars = [
            "lang": "en"
        ]
        let url = URLs.categories
        print(url)
        print(parametars)
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let categories = try JSONDecoder().decode(Categories.self, from: response.data!)
                    if categories.status == false {
                        completion(nil,true,categories)
                    }else {
                        completion(nil,true,categories)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
    
    
    class func allProducts(category_id: String,completion: @escaping(_ error: Error?,_ success: Bool,_ products: Offers?)-> Void){
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        let parametars = [
            "lang": "en",
            "category_id": category_id
        ]
        let url = URLs.productsCategory
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
                    let products = try JSONDecoder().decode(Offers.self, from: response.data!)
                    if products.status == false {
                        completion(nil,true,products)
                    }else {
                        completion(nil,true,products)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
}
