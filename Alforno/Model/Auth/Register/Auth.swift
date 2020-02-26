//
//  registerModel.swift
//  Alforno
//
//  Created by Ahmed farid on 2/26/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct Auth: Codable {
    let data: Data?
    let status: Bool?
}

struct Data: Codable {
    let userToken, name, email, phone: String?
    let roleID: Int?
    let roleName: String?

    enum CodingKeys: String, CodingKey {
        case userToken = "user_token "
        case name, email, phone
        case roleID = "role_id"
        case roleName = "role_name"
    }
}
