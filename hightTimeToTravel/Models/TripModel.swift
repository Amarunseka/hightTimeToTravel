//
//  TripModel.swift
//  hightTimeToTravel
//
//  Created by Миша on 31.05.2022.
//

import Foundation

struct TripModel: Codable {
    let startCity: String
    let startCityCode: String
    let endCity: String
    let endCityCode: String
    let startDate: String
    let endDate: String
    let price: Int
    let searchToken: String
}
