//
//  EarthquakeResponse.swift
//  Earthquack
//
//  Created by GOZDE KARDAS on 9.06.2021.
//

import Foundation

// MARK: - EarthquakeResponse
struct EarthquakeResponse: Codable {
    let type: String
    let features: [Features]
}
