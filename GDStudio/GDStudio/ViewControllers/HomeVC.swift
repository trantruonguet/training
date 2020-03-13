//
//  ViewController.swift
//  GDStudio
//
//  Created by DatTH-GD on 3/11/20.
//  Copyright © 2020 DatTH-GD. All rights reserved.
//

import UIKit
import RealmSwift

class HomeVC: UIViewController {
    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var lbpasword: UILabel!
    @IBOutlet weak var avatrImageView: UIImageView!
    
    
    @IBOutlet weak var usename: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        password.delegate = self
        usename.delegate = self
        btnLogin.layer.cornerRadius = 8
        avatrImageView.layer.cornerRadius = 150/2
    }
    
    
    @IBAction func actionLogin(_ sender: Any) {
        
        createUser(username: usename.text!, password: password.text!, image: avatrImageView.image!)
        
    }
    
}

extension HomeVC {
    
    
    private func isUserExist(username: String) -> Users? {
        let realm = try? Realm()
        let existUser = realm?.object(ofType: Users.self, forPrimaryKey: username)
        return existUser
    }
    
    private func alertCreateUser(username: String) {
        //Khởi tạo UIAlertController
        let alert = UIAlertController(title: "Tai khoan khong ton tai", message: "Ban co muon tao tai khoan moi voi user name: \(username) khong?", preferredStyle: .alert)
        
        //Khởi tạo các action (các nút) cho alert
        let alertActionOk = UIAlertAction(title: "OK", style: .default) { (act) in
            self.getImage()
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (act) in
            print("action destructive") //action khi nhấn nút Cancel
        }
        
        //Thêm các action vào alert
        alert.addAction(alertActionOk)
        alert.addAction(alertActionCancel)
        
        //Hiển thị alert
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func createUser(username: String, password: String, image: UIImage) {
       let user = Users()
        user.name = username
        user.password = password
        user.image = image.pngData()
        let realm = try? Realm()
        try? realm?.write({
            realm?.add(user, update: .all)
        })
    }
    
}
extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == usename {
            if let user = isUserExist(username: textField.text!), let data = user.image {
                password.isEnabled = true
                avatrImageView.image = UIImage(data: data)
            } else {
                //TODO: show dialog hoi co muon tao user ko
                alertCreateUser(username: textField.text!)
            }
        } else if textField == password {
            if textField.text!.count >= 6 {
                btnLogin.isEnabled = true
            } else {
                btnLogin.isEnabled = false
            }
            
        }
        
        return true
    }
}


extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage {
            avatrImageView.image = image
            password.isEnabled = true
        }
        
    }
}

private func password(passwod: String)->Bool{
    
    
    
    return false
}















