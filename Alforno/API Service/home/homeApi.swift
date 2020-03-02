//
//  sliderAPi.swift
//  Alforno
//
//  Created by Ahmed farid on 2/26/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class homeApi: NSObject {
    
    
    class func sliderApi(completion: @escaping(_ error: Error?,_ success: Bool,_ photos: Slider?)-> Void){
        
        let parametars = [
            "lang": "en"
        ]
        let url = URLs.slider
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
                    let images = try JSONDecoder().decode(Slider.self, from: response.data!)
                    if images.status == false {
                        completion(nil,true,images)
                    }else {
                        completion(nil,true,images)
                    }
                }catch{
                    print("error")
                }
            }
        }
        
    }
    
    class func offersApi(completion: @escaping(_ error: Error?,_ success: Bool,_ offer: Offers?)-> Void){
        
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
        
        let url = URLs.offersProducts
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
                    let offer = try JSONDecoder().decode(Offers.self, from: response.data!)
                        completion(nil,true,offer)
                }catch{
                    print("error")
                }
            }
        }
        
    }
    
}

