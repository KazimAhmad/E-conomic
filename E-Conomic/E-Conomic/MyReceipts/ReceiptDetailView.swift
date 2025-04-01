//
//  ReceiptDetailView.swift
//  E-Conomic
//
//  Created by Kazim Ahmad on 01/04/2025.
//

import SwiftUI

struct ReceiptDetailView: View {
    var imageData: Data?
    
    var body: some View {
        ZStack {
            if let imageData = imageData {
                if let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
        }
    }
}

#Preview {
    ReceiptDetailView()
}
