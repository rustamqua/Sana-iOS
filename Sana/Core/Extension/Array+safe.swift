//
//  Array+safe.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 18.04.2022.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension String {
    subscript(idx: Int) -> String? {
        guard self.count - 1 >= idx else { return nil }
        
        return String(self[index(startIndex, offsetBy: idx)])
    }
}
