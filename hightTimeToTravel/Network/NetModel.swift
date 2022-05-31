//
//  NetModel.swift
//  hightTimeToTravel
//
//  Created by Миша on 30.05.2022.
//

import Foundation

struct NetModel: Codable {
    
    let meta: Meta
    let data: [TripModel]

    struct Meta: Codable {
    }
}
