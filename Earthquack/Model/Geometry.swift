//
//  Geometry.swift
//  Earthquack
//
//  Created by GOZDE KARDAS on 11.06.2021.
//

import Foundation

struct Geometry: Codable {
    let type: GeometryType
    let coordinates: [Double]
}

enum GeometryType: String, Codable {
    case point = "Point"
}

