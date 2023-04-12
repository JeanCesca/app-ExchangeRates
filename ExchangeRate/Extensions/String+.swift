//
//  Date+.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import Foundation

extension String {
    
    func toDate(dateFormat: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self) ?? Date()
    }
    
    
}
