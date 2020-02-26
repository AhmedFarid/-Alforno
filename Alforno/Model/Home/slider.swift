//
//  slider.swift
//  Alforno
//
//  Created by Ahmed farid on 2/26/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct Slider: Codable {
    let data: [dataSlider]?
    let status: Bool?
}

struct dataSlider: Codable {
    let image: String?
}
