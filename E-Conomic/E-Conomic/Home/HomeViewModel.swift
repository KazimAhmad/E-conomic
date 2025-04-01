//
//  HomeViewModel.swift
//  E-Conomic
//
//  Created by Kazim Ahmad on 01/04/2025.
//

import UIKit

class HomeViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var sourceType: UIImagePickerController.SourceType = .camera
}
