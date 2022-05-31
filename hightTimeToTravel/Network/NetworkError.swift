//
//  NetworkError.swift
//  hightTimeToTravel
//
//  Created by Миша on 31.05.2022.
//

import Foundation

enum NetworkError: Error {
    case `default`
    case serverError
    case parseError(reason: String)
    case unknownError
}
