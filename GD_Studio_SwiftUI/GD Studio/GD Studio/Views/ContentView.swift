//
//  ContentView.swift
//  GD Studio
//
//  Created by PhucND-GD on 3/19/20.
//  Copyright © 2020 PhucND-GD. All rights reserved.
//

import SwiftUI


class ContentViewModel: ObservableObject, Identifiable {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isShowAlertCreateUser: Bool = false
    @Published var isShowAlertInvalidPasswrd: Bool = false
    @Published var showImagePicker: Bool = false
    @Published var image: UIImage? = nil
    
    
    func checkLoginUser() {
        guard let user =  RealmDBManager.shared.isUserExist(username: username), let data = user.avtar else {
            isShowAlertCreateUser = true
            return
        }
        image = UIImage(data: data)
    }
    
    func saveuserAndLogin() -> Bool {
        guard  let imageData = image?.resizeImage(targetSize: .init(width: 100, height: 100))?.pngData()else {return false}
        if let user = RealmDBManager.shared.isUserExist(username: username), user.password != password {
            isShowAlertInvalidPasswrd = true
            return false
        }
        RealmDBManager.shared.insertUser(username: username, passwrod: password, iamge: imageData)
        return true
    }
    
}

struct ContentView: View {
    
    @EnvironmentObject var env: AppObject
    
    @ObservedObject var viewModel = ContentViewModel()

    
    var body: some View {
        VStack {
            (viewModel.image != nil ? Image(uiImage: viewModel.image!) : Image(systemName: "person.crop.circle"))
                .resizable()
                .frame(width: 90, height: 90)
                .cornerRadius(45)
                .foregroundColor(.orange)
            Text("GD STUDIO")
                .foregroundColor(.init(red: 241/255, green: 89/255, blue: 89/255))
                .font(.system(size: 48))
                .fontWeight(.heavy)
                .shadow(radius: 5)
            HStack(spacing: 20) {
                Text("Username").frame(width: 100)
                TextField("", text: $viewModel.username) {
                    self.viewModel.checkLoginUser()
                }.textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.horizontal)
            HStack(spacing: 20) {
                Text("Password").frame(width: 100)
                SecureField("", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(viewModel.username.isEmpty)
            }.padding(.horizontal)
            Spacer().frame(height: 50)
            Button(action: {
                self.env.isAuth = self.viewModel.saveuserAndLogin()
                self.env.username = self.viewModel.username
            }) {
                Text("Login")
                    .frame(width: 150, height: 50)
                    .foregroundColor(.black)
                    .background(viewModel.password.isEmpty ? Color.gray:Color.init(hex: "C7DE86"))
                    .cornerRadius(10)
            }.disabled(viewModel.password.isEmpty)
        }.sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(uiImage: self.$viewModel.image)
        }.alert(isPresented: $viewModel.isShowAlertInvalidPasswrd, content: alertInvalidPassword)
        .alert(isPresented: $viewModel.isShowAlertCreateUser, content: {
            self.alertCreatUser()
        })
    }
    
    func alertCreatUser() -> Alert {
        let okAction = Alert.Button.default(Text("OK"), action: {self.viewModel.showImagePicker = true})
        let cancelAction = Alert.Button.destructive(Text("Cancel"), action: { self.viewModel.username = ""})
        let alert = Alert(title: Text("User not found! Do you want to create new user"), primaryButton: okAction, secondaryButton: cancelAction)
        return alert
    }
    
    func alertInvalidPassword() -> Alert {
        let alert = Alert(title: Text("Password is not correct"))
        return alert
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
