//
//  Api.swift
//  Bebeep
//
//  Created by shy attoun on 21/05/2022.
//

import Foundation
import UIKit

struct Api {
   static var User = UserApi()
    static var Message = MessageApi()
    static var Inbox = InboxApi()
}

struct UserDetails {
    var id_number: String?
    var uid: String?
    var phone: String?
    var car_license: String?
    

}


