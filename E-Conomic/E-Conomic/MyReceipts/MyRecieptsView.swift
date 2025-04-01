//
//  ContentView.swift
//  E-Conomic
//
//  Created by Kazim Ahmad on 31/03/2025.
//

import SwiftUI
import CoreData

struct MyRecieptsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Receipt.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Receipt>

    var body: some View {
        List {
            ForEach(items, id: \.id) { item in
                NavigationLink {
                    ReceiptDetailView(imageData: item.image)
                } label: {
                    HStack(spacing: 16.0) {
                        if let imageData = item.image {
                            if let image = UIImage(data: imageData) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60,
                                           height: 100)
                                    .padding()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(item.title ?? "")
                                .foregroundStyle(Color.purple)
                                .font(.title)
                            Text(item.details ?? "")
                            HStack {
                                Text(String(item.total))
                                if let currency = Currency.allCases.first(where: { $0.rawValue == item.currency }) {
                                    Text(currency.symbol)
                                }
                            }
                            .font(.caption)
                            Text(item.timestamp ?? Date(),
                                 formatter: itemFormatter)
                                .font(.caption)
                        }
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    MyRecieptsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
