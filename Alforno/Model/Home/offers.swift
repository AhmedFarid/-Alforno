//
//  offers.swift
//  Alforno
//
//  Created by Ahmed farid on 2/27/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


import Foundation

struct Offers: Codable {
    let data: [offfersData]?
    let status: Bool?
    let error: String?
}

struct offfersData: Codable {
    let id: Int?
    let title, shortDescription, offerDescription, priceGeneral: String?
    let salePrice, image: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case shortDescription = "short_description"
        case offerDescription = "description"
        case priceGeneral = "price_general"
        case salePrice = "sale_price"
        case image
    }
}
