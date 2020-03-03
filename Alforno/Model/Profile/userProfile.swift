//
//  userProfile.swift
//  Alforno
//
//  Created by Ahmed farid on 3/3/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct userProfile: Codable {
    let data: [profileData]?
    let status: Bool?
    let error: String?
}
 
struct profileData: Codable {
    let id: Int?
    let name, phone, email: String?
}

struct editProfiel: Codable {
    let data: String?
    var status: Bool?
    let error: String?
}

