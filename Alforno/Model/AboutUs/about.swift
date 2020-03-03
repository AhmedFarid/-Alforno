//
//  about.swift
//  Alforno
//
//  Created by Ahmed farid on 3/3/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct About: Codable {
    let data: [Datum]?
    let status: Bool?
    let error: String?
}

struct Datum: Codable {
    let image, title, datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case image, title
        case datumDescription = "description"
    }
}
