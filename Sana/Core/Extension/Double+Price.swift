//
//  Double+Price.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import Foundation

extension Double {
    static let currencyFormatter: NumberFormatter = .init()
    
    func toCurrency() -> String {
        Self.currencyFormatter.groupingSeparator = " "
        Self.currencyFormatter.numberStyle = .decimal
        Self.currencyFormatter.maximumFractionDigits = 0
        
        return "\(Self.currencyFormatter.string(from: NSNumber(value: self)) ?? "") ₸"
    }
}
