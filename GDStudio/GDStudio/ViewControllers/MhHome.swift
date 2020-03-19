//
//  MhHome.swift
//  GDStudio
//
//  Created by AnhNT-GD on 3/16/20.
//  Copyright © 2020 DatTH-GD. All rights reserved.
//

import UIKit
import RealmSwift

class MhHome: UIViewController {
   
    @IBOutlet weak var status: UITextField!
    @IBOutlet weak var avata: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        status.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openWriteSatus)))
        // Do any additional setup after loading the view.
      }
    @objc func openWriteSatus(){
        let stt = self.storyboard?.instantiateViewController(withIdentifier: "Statut") as! Statut
              
        self.navigationController?.pushViewController(stt, animated: true)
        
    }

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

