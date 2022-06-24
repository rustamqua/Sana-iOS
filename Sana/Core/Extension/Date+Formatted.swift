//
// Created by Rustam-Deniz Emirali on 20.06.2022.
//

import Foundation

let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM dd, yyyy"
    return dateFormatter
}()

extension Date {
    func formatted() -> String {
       dateFormatter.string(from: self)
    }
}