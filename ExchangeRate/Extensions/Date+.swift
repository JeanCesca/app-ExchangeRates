//
//  Date+.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 11/04/23.
//

import Foundation

extension Date {
    
    init(from component: Calendar.Component, value: Int) {
        self = Calendar.current.date(byAdding: component, value: -value, to: Date()) ?? Date()
    }
    
    func formatter(to dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR_POSIX")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    func toString(dateFormat: String = "yyyy-MM-dd") -> String {
        return formatter(to: dateFormat)
    }
}
