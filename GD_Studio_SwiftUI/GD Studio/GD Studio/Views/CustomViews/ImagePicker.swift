//
//  ImagePicker.swift
//  GD Studio
//
//  Created by PhucND-GD on 3/19/20.
//  Copyright © 2020 PhucND-GD. All rights reserved.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    var presentationMode
    @Binding var uiImage: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var presentationMode: PresentationMode
        @Binding var uiImage: UIImage?

        init(presentationMode: Binding<PresentationMode>, image: Binding<UIImage?>) {
            _presentationMode = presentationMode
            _uiImage = image
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.uiImage = uiImage
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $uiImage)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}
