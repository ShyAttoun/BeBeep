//
//  File.swift
//  Bebeep
//
//  Created by shy attoun on 21/05/2022.
//

import Foundation
import UIKit

class User  {
    
    static var currentUser: User?
    
    var uid: String
    var idnumber: String
    var email: String
    var phone: String
    var car_license: String
   

    
    init(uid:String , idnumber: String , email: String , phone: String , car_license: String) {
        self.uid = uid
        self.idnumber = idnumber
        self.email = email
        self.phone = phone
        self.car_license = car_license
    }
      

    

    static func transformUser (dict: [String: Any]) -> User? {
        guard let email = dict["email"] as? String,
              let idnumber = dict["idnumber"] as? String,
              let uid = dict["uid"] as? String,
              let phone = dict["phone"] as? String,
              let car_license = dict ["car_license"] as? String
                
        else{
            return nil
            
        }
        
 
        
        let user = User(uid: uid, idnumber: idnumber, email: email, phone: phone, car_license: car_license)
        
    
        return user
    }
    
    func toDict() -> [String: Any] {
        var dict = [String: Any]()
        dict["uid"] = uid
        dict["idnumber"] = idnumber
        dict["email"] = email
        dict["phone"] = phone
        dict["car_license"] = car_license
       
      
        return dict
    }

        
    func updateData(key: String, value: Any) {
        switch key {
        case "uid": self.uid  = value as! String
        case "idnumber": self.idnumber = value as! String
        case "email": self.email = value as! String
        case "phone": self.phone = value as! String
        case "car_license": self.car_license = value as! String
        
        default: break
        }
    }
}


