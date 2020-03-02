//
//  categories.swift
//  Alforno
//
//  Created by Ahmed farid on 3/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let data: [catData]?
    let status: Bool?
    let error: String?
}

struct catData: Codable {
    let id: Int?
    let image, title, shortDescription, datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, image, title
        case shortDescription = "short_description"
        case datumDescription = "description"
    }
}
