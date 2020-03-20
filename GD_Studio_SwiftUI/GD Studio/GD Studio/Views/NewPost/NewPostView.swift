//
//  NewPostView.swift
//  GD Studio
//
//  Created by PhucND-GD on 3/19/20.
//  Copyright © 2020 PhucND-GD. All rights reserved.
//

import SwiftUI

struct NewPostView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var env: AppObject
    
    @State private var text = ""
    @State private var height: CGFloat = 80
    @State private var isShowImagePicker = false
    @State private var pickedImage = UIImage(named: "image2")
    var body: some View {
        VStack {
            // User info
            userInfoView
            // Content
            contentView
            Spacer().frame(height: 40)
            selectionRow(title: "Privacy: ", value: "Public")
            selectionRow(title: "Location: ", value: "hanoi")
            //sahre button
            Button(action: {
                if let user = RealmDBManager.shared.isUserExist(username: self.env.username), let data = self.pickedImage?.pngData() {
                    RealmDBManager.shared.insertPost(content: self.text, image: data, location: "Ha noi", user: user)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Share").font(.headline).foregroundColor(.white).frame(width: UIScreen.main.bounds.width-30, height: 50)
                }).buttonStyle(BorderlessButtonStyle())
                .background(Color.init(hex: "D6DB46"))
                .cornerRadius(8)
            Spacer()
        }.sheet(isPresented: $isShowImagePicker) {
            ImagePicker(uiImage: Binding(get:{ self.pickedImage}, set: {self.pickedImage = $0?.resizeImage(targetSize: .init(width: 500, height: 500))}))
        }
    }
    
    
    private var userInfoView: some View {
        return HStack(spacing: 10) {
            Image(systemName: "person.crop.circle").resizable().scaledToFit().frame(width: 40, height: 40)
                Text("Phucnd")
            Spacer()
        }.padding(EdgeInsets(top: 25, leading: 15, bottom: 20, trailing: 15))
    }
    
    private var contentView: some View {
        return HStack(alignment: .top) {
            Image(uiImage: self.pickedImage!).resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 80).clipped()
            .onTapGesture {
                self.isShowImagePicker = true
            }
            MultilineTextField("Bạn đang nghĩ gì?", text: $text, onCommit: nil)
        }.padding([.leading, .trailing], 15)
    }
    
    private func selectionRow(title: String, value: String) -> some View {
        return VStack {
            HStack {
                Text(title).font(.caption).fontWeight(.bold)
                Spacer()
                Text(value).font(.caption).foregroundColor(.gray)
            }
            Rectangle().frame(height: 1).foregroundColor(Color.gray.opacity(0.2))
        }.padding([.leading, .trailing], 15)
    }
}





//struct NewPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPostView.init
//    }
//}
