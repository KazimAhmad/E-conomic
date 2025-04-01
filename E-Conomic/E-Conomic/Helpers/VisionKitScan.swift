//
//  VisionKitScan.swift
//  E-Conomic
//
//  Created by Kazim Ahmad on 01/04/2025.
//

import UIKit
import SwiftUI
import VisionKit

struct VNDocumentCameraViewControllerRepresentable: UIViewControllerRepresentable {
    @Binding var scanResult: UIImage?
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = context.coordinator
        
        return documentCameraViewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scanResult: $scanResult)
    }
    
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        @Binding var scanResult: UIImage?
        
        init(scanResult: Binding<UIImage?>) {
            _scanResult = scanResult
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            if scan.pageCount > 0 {
                scanResult = scan.imageOfPage(at: 0)
            }
            controller.dismiss(animated: true, completion: nil)
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            controller.dismiss(animated: true, completion: nil)
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document scanner error: \(error.localizedDescription)")
            controller.dismiss(animated: true, completion: nil)
        }
    }
}
