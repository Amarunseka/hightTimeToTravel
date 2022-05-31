//
//  DateTransformer.swift
//  hightTimeToTravel
//
//  Created by Миша on 31.05.2022.
//

import Foundation

class DateTransformer {
    
    class func transformDate(_ dateString: String) -> String {
        let formatterForInDate = DateFormatter()
        formatterForInDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let inDate = formatterForInDate.date(from: dateString)
        
        let formatterForOutDate = DateFormatter()
        formatterForOutDate.dateFormat = "dd.MM.yyyy"
        
        guard let inDate = inDate else { return ""}
        
        let outDate = formatterForOutDate.string(from: inDate)
        return outDate
    }
}
