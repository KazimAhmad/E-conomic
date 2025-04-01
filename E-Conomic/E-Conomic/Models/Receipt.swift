//
//  Receipt.swift
//  E-Conomic
//
//  Created by Kazim Ahmad on 01/04/2025.
//

import UIKit

enum ViewState {
    case loading
    case empty
    case info
    case error
}

enum Currency: String, CaseIterable {
    case euro = "Euro"
    case dollars = "Dollar"
    case pounds = "Pounds"
    case franc = "Franc"
    case yen = "Yen"
    case real = "Real"
    
    var symbol: String {
        switch self {
        case .euro:
            return "€"
        case .dollars:
            return "$"
        case .pounds:
            return "£"
        case .franc:
            return "Fr"
        case .yen:
            return "¥"
        case .real:
            return "R$"
        }
    }
}

struct ReceiptObject {
    let id: String
    var timeStamp: Date
    let image: UIImage
    
    var title: String
    var details: String
    var total: Double
    var currency: Currency
    
    init(id: String, timeStamp: Date, image: UIImage, title: String, details: String, total: Double, currency: Currency) {
        self.id = id
        self.timeStamp = timeStamp
        self.image = image
        self.title = title
        self.details = details
        self.total = total
        self.currency = currency
    }
    
    func timeStampString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYY hh:mm:ss"
        return formatter.string(from: timeStamp)
    }
}
