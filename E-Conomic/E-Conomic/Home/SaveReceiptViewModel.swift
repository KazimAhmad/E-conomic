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
    let viewContext: NSManagedObjectContext
    @Published var receipt: ReceiptObject
    @Published var viewState: ViewState = .info

    init(image: UIImage,
         viewContext: NSManagedObjectContext) {
        self.receipt = ReceiptObject(id: UUID().uuidString,
                                     timeStamp: Date(),
                                     image: image,
                                     title: "",
                                     details: "",
                                     total: 0.0,
                                     currency: .euro)
        self.viewContext = viewContext
    }
    
    func save() async throws {
        Task {
            viewState = .loading
            let newItem = Receipt(context: viewContext)
            newItem.id = receipt.id
            newItem.title = receipt.title
            newItem.details = receipt.details
            newItem.timestamp = receipt.timeStamp
            newItem.total = receipt.total
            newItem.currency = receipt.currency.rawValue
            if let imageData = receipt.image.pngData() {
                newItem.image = imageData
            }
            do {
                try viewContext.save()
            } catch {
                print(error)
                viewState = .error
            }
        }
    }
}
