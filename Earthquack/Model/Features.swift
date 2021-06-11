//
//  Features.swift
//  Earthquack
//
//  Created by GOZDE KARDAS on 11.06.2021.
//

import Foundation

struct Features: Codable {
    let properties: Properties
    let geometry: Geometry
    let id: String
}

struct Properties: Codable {
    let mag: Double?
    let place: String?
    let time: Int?
}
