//
//  productDitelas.swift
//  Alforno
//
//  Created by Ahmed farid on 3/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct ProductsSize: Codable {
    let data: [dataSize]?
    let status: Bool?
    let error: String?
}

// MARK: - Datum
struct dataSize: Codable {
    let id: Int?
    let size, price, salePrice: String?

    enum CodingKeys: String, CodingKey {
        case id, size, price
        case salePrice = "sale_price"
    }
}
