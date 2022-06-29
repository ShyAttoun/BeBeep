//
//  UserAPI.swift
//  Bebeep
//
//  Created by shy attoun on 21/05/2022.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import ProgressHUD
import FirebaseFirestore

class UserApi {
    
    var currentUserId: String {
        return Auth.auth().currentUser != nil ? Auth.auth().currentUser!.uid : ""
    }
    
    func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            onSuccess()
        }
    }
    
    func signUp (withUsername username: String, email: String, password: String, image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                
                return
            }
            if let authData = authDataResult {
                print(authData.user.email)
                let _: Dictionary<String, Any> =  [
                    UID: authData.user.uid,
                    EMAIL: authData.user.email!,
                    USERNAME: username,
                   
                ]
    
                
            }
        }
    }
    
    
    func getUserInfor(uid: String, onSuccess: @escaping(UserCompletion)) {
        let ref = DatabaseProvider().databaseSpecificUser(uid: uid)
        ref.observe(.value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                if let user = User.transformUser(dict: dict) {
                    onSuccess(user)
                }
            }
        }
    }
}
    
 
typealias UserCompletion = (User) -> Void
    
