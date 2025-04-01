//
//  SaveReceiptViewModel.swift
//  E-Conomic
//
//  Created by Kazim Ahmad on 01/04/2025.
//
import CoreData
import SwiftUI
import UIKit

class SaveReceiptViewModel: ObservableObject {
    @Environment(\.managedObjectContext) private var viewContext

    @Published var receipt: ReceiptObject
    
    init(image: UIImage) {
        self.receipt = ReceiptObject(id: UUID().uuidString,
                                     timeStamp: Date(),
                                     image: image,
                                     title: "",
                                     details: "",
                                     total: 0.0,
                                     currency: .euro)
    }
    
    func save() {

    }
}
