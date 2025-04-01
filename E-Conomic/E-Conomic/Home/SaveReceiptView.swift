//
//  SaveReceiptView.swift
//  E-Conomic
//
//  Created by Kazim Ahmad on 01/04/2025.
//

import SwiftUI

struct SaveReceiptView: View {
    @ObservedObject var viewModel: SaveReceiptViewModel
    @State var empty: String = ""
    
    var body: some View {
        ScrollView {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.gray)
                .frame(width: 60,
                       height: 4)
                .padding(.top)
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: viewModel.receipt.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200,
                               height: 300,
                               alignment: .leading)
                    Spacer()
                }
                .padding(.bottom)
                Rectangle()
                    .frame(height: 1)
                    .padding(.horizontal)
                Text("Information")
                    .font(.largeTitle)
                    .foregroundStyle(.purple)
                TextField("Title",
                          text: $viewModel.receipt.title)
                TextField("Details",
                          text: $viewModel.receipt.details)
                HStack {
                    TextField("Total",
                              value: $viewModel.receipt.total, formatter: NumberFormatter())
                    .keyboardType(.decimalPad)
                    
                    Picker(selection: $viewModel.receipt.currency) {
                        ForEach(Currency.allCases, id: \.rawValue) { currency in
                            Text(currency.symbol + " " + currency.rawValue).tag(currency)
                        }
                    } label: {
                        Text(viewModel.receipt.currency.symbol)
                    }
                    .tint(Color.purple)
                    
                }
                TextField(viewModel.receipt.timeStampString(),
                          text: $empty)
                .disabled(true)
                
                Button {
                    viewModel.save()
                } label: {
                    Text("Save")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 16.0,
                                             style: .circular)
                            .fill(Color.purple)
                            .frame(height: 60)
                        }
                }
                .padding(.vertical, 32)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }
}

#Preview {
    SaveReceiptView(viewModel: SaveReceiptViewModel(image: UIImage(systemName: "text.page")!))
}
