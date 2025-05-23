//
//  HomeView.swift
//  E-Conomic
//
//  Created by Kazim Ahmad on 31/03/2025.
//

import SwiftUI

struct HomeView: View {

    @State private var isShowingImagePicker: Bool = false
    @State private var isShowingVNDocumentCameraView = false
    @State private var isShowingSaveView = false

    @State private var selectedImage: UIImage?
    @ObservedObject var viewModel = HomeViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Menu {
                    Button("Scan") {
                        isShowingVNDocumentCameraView = true
                    }
                    Button("Photos") {
                        viewModel.sourceType = .photoLibrary
                        isShowingImagePicker.toggle()
                    }
                    Button("Camera") {
                        viewModel.sourceType = .camera
                        isShowingImagePicker.toggle()
                    }
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(Color.purple)
                        .shadow(color: .gray,
                                radius: 8.0,
                                x: 4,
                                y: 4)
                }
                Spacer()
                Text("Keep all your recipts safe and in one place")
                    .font(.footnote)
                    .fontWeight(.bold)
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePickerView(selectedImage: self.$selectedImage,
                                sourceType: viewModel.sourceType)
            }
            .sheet(isPresented: $isShowingVNDocumentCameraView) {
                VNDocumentCameraViewControllerRepresentable(scanResult: $selectedImage)
            }
            .sheet(isPresented: $isShowingSaveView,
                   content: {
                if let image = selectedImage {
                    SaveReceiptView(viewModel: SaveReceiptViewModel(image: image,
                                                                    viewContext: viewContext))
                }
            })
            .navigationTitle("E-Conomic")
            .tint(.white)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: MyRecieptsView()) {
                        Image(systemName: "text.page")
                            .foregroundStyle(Color.white)
                    }
                }
            }
            .toolbarBackgroundVisibility(.visible,
                                         for: .navigationBar)
            .toolbarBackground(Color.purple,
                               for: .navigationBar)
        }
        .onChange(of: selectedImage) {
            if selectedImage != nil {
                isShowingSaveView = true
            }
        }
    }
}

#Preview {
    HomeView()
}
