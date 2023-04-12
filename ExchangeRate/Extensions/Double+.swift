//
//  Double+.swift
//  ExchangeRate
//
//  Created by Jean Ricardo Cesca on 06/04/23.
//

import Foundation
import SwiftUI

extension Double {
    
    func formatter(decimalPlaces: Int, changeSymbol: Bool = false) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .halfUp
        numberFormatter.minimumFractionDigits = (decimalPlaces > 2) ? decimalPlaces : 2
        numberFormatter.maximumFractionDigits = (decimalPlaces > 2) ? decimalPlaces : 2
        numberFormatter.locale = Locale(identifier: "pt_BR")
        
        guard let value = numberFormatter.string(from: NSNumber(value: self)) else { return String(self) }
        
        if changeSymbol {
            if self.sign == .minus {
                return "\(value)"
            } else {
                return "+\(value)"
            }
                
        }

        return value.replacingOccurrences(of: "-", with: "")
    }
    
    func toPercentage(changeSymbol: Bool = false) -> String {
        let value = formatter(decimalPlaces: 2)
        
        if changeSymbol {
            if self.sign == .minus {
                return "\u{2193} \(value)%"
            } else {
                return "\u{2191} \(value)%"
            }
        }
        return value
    }

    var color: Color {
        if self.sign == .minus {
            return .red
        } else {
            return Color("positive")
        }
    }
}
