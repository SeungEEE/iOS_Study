////
////  ImagePicker.swift
////  VisionPractice
////
////  Created by 이승진 on 4/9/25.
////
//
//import SwiftUI
//import PhotosUI
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Environment(\.dismiss) var dismiss
//    var imageHandler: ImageHandling
//    var selectedLimit: Int
//    
//    /// UIKit 뷰
//    func makeUIViewController(context: Context) -> some UIViewController {
//        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
//        config.selectionLimit = selectedLimit
//        config.filter = .images
//        
//        let picker = PHPickerViewController(configuration: config)
//        picker.delegate = context.coordinator
//        return picker
//    }
//    
//    /// View가 업데이트될 때 호출
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self, imageHandler: imageHandler)
//    }
//    
//    /// SwiftUI와 UIKit의 Delegate를 연결해주는 중간 관리자
//    class Coordinator: NSObject, PHPickerViewControllerDelegate {
//        var parent: ImagePicker
//        var imageHandler: ImageHandling
//        
//        init(parent: ImagePicker, imageHandler: ImageHandling) {
//            self.parent = parent
//            self.imageHandler = imageHandler
//        }
//        
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            self.parent.dismiss()
//            
//            for result in results {
//                result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
//                    if let image = object as? UIImage {
//                        DispatchQueue.main.async {
//                            self.imageHandler.addImage(image)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
