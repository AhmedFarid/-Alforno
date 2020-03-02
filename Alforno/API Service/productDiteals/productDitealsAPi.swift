//
//  productDitealsAPi.swift
//  Alforno
//
//  Created by Ahmed farid on 3/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class productDitealsAPi: NSObject {
    
    class func productSizes(product_id: String,completion: @escaping(_ error: Error?,_ success: Bool,_ productSize: ProductsSize?)-> Void){
        let parametars = [
            "lang": "en",
            "product_id": product_id
        ]
        let url = URLs.productsSize
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
                    let productSize = try JSONDecoder().decode(ProductsSize.self, from: response.data!)
                    if productSize.status == false {
                        completion(nil,true,productSize)
                    }else {
                        completion(nil,true,productSize)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
}
