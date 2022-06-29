//
//  Ref.swift
//  Bebeep
//
//  Created by shy attoun on 21/05/2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage


let REF_USER = "users"
let REF_MESSAGE = "messages"
let REF_INBOX = "inbox"
let REF_ACTION = "action"


let URL_STORAGE_ROOT = "gs://shwing-8a339.appspot.com"
let STORAGE_PROFILE = "profile"
let LOGO_IMAGE_URL = "logo image"
let UID = "uid"
let EMAIL = "email"
let USERNAME = "username"
let IS_ONLINE = "isOnline"


let ERROR_EMPTY_PHOTO = "Please choose your profile image"
let ERROR_EMPTY_EMAIL = "Please enter an email address"
let ERROR_EMPTY_USERNAME = "Please enter an username"
let ERROR_EMPTY_PASSWORD = "Please enter a password"
let ERROR_EMPTY_EMAIL_RESET = "Please enter an email address for password reset"

let SUCCESS_EMAIL_RESET = "We have just sent you a password reset email. Please check your inbox and follow the instructions to reset your password"

let IDENTIFIER_TABBAR = "TabBarVC"
let IDENTIFIER_WELCOME = "WelcomeVC"
let IDENTIFIER_CHAT = "ChatVC"
let IDENTIFIER_HOME = "HomeVC"
let IDENTIFIER_USER_AROUND = "UsersAroundViewController"
let IDENTIFIER_BUISNESS_AROUND = "BuisnessLocationCollectionViewController"
let IDENTIFIER_MAP = "MapViewController"
let IDENTIFIER_BUISNESS_MAP = "BuisnessMapViewController"
let IDENTIFIER_DETAIL = "DetailViewController"
let IDENTIFIER_RADAR = "RadarViewController"
let IDENTIFIER_NEW_MATCH = "NewMatchTableViewController"


let IDENTIFIER_CELL_USERS = "UserTableViewCell"


struct C {
    
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let appName = "RealTalk"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "feedMessages"
        static let senderField = "from"
        static let bodyfield = "text"
        static let dateField = "date"
    }
}
class DatabaseProvider{
    
    let databaseRoot: DatabaseReference = Database.database().reference()

    var databaseInbox: DatabaseReference {
        return databaseRoot.child(REF_INBOX)
    }
    
    func databaseInboxInFor (from: String, to: String) -> DatabaseReference {
        return databaseInbox.child(from).child(to)
    }
    
    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_INBOX)
    }
    
    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }
    
    var databaseMessage: DatabaseReference {
        return databaseRoot.child(REF_MESSAGE)
    }
    
    func databaseMessageSendTo(from: String, to: String) -> DatabaseReference {
        return databaseMessage.child(from).child(to)
    }
    
   

    
    func databaseInboxInForUser (uid: String) -> DatabaseReference {
        return databaseInbox.child(uid)
    }

    
   
    
    
   
    
}

