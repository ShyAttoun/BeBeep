//
//  ViewController.swift
//  Bebeep
//
//  Created by shy attoun on 21/05/2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import ProgressHUD
import FirebaseDatabase
import FirebaseMessaging
import FirebaseStorage

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var bottomConsLoign: NSLayoutConstraint!
    @IBOutlet weak var loginSeg: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cellularTextField: UITextField!
    @IBOutlet weak var licesnePlaterTextField: UITextField!
    @IBOutlet weak var idNumberTextField: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    
    let db =  Firestore.firestore()
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        licesnePlaterTextField.isHidden = true

    }

    
    @IBAction func segAction(_ sender: UISegmentedControl) {
        if loginSeg.selectedSegmentIndex == 0 {
            licesnePlaterTextField.isHidden = true
           
            LoginBtn.setTitle("LOGIN", for: UIControl.State.normal)
            
        }else if loginSeg.selectedSegmentIndex == 1{
            licesnePlaterTextField.isHidden = false
            LoginBtn.setTitle("SIGN UP", for: UIControl.State.normal)
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        if loginSeg.selectedSegmentIndex == 0 {
            
            signInUser(email:emailTextField.text!,password: cellularTextField.text!)
//            Api.User.isOnline(bool: true)
           
            
        }else if loginSeg.selectedSegmentIndex == 1 {
            createUser(idNumber: idNumberTextField.text!, email:emailTextField.text!, phone: cellularTextField.text!)
//            Api.User.isOnline(bool: true)

        }
    }
    
    func createUser (idNumber:String , email:String , phone: String ) {
        if self.idNumberTextField.text == "" || self.emailTextField.text == "" || self.cellularTextField.text == ""  {
         
            ProgressHUD.showError("please fill all fields")
        }
        else{
            Auth.auth().createUser(withEmail: email, password: idNumber ) {(user,error) in
                if error == nil {
//

                    print("User created")
                    self.signInUser( email:email,password: idNumber)
                    if let authData = user {
                        
                        
                        let dic: Dictionary<String,Any> = [
                            "uid" : authData.user.uid ,
                            "email": authData.user.email as Any ,
                            "id_number": idNumber,
                            "phone": phone ,
                            "car_license" : self.licesnePlaterTextField.text as Any 

                        ]
                        
                        let docRef = self.db.collection("Users").document()
                        docRef.setData(dic){error in
                            
                            if error == nil {
                                print("done")
                            }
                            else{
                                ProgressHUD.showError(error!.localizedDescription)
                            }
                        }
        
                    }
                }else{
                    ProgressHUD.showError(error!.localizedDescription)
                }
            }
        }
    }
    
    
    func signInUser ( email:String  , password: String){
        
        if  self.emailTextField.text == "" || self.idNumberTextField.text == "" || self.cellularTextField.text == "" {
            print("please fill all fields")
        }
        else {
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.idNumberTextField.text!){
                [weak self]  (user,error)in
                
                if error == nil {
//                    Api.User.isOnline(bool: true)
                   
                    let mainSB = UIStoryboard(name: "Main", bundle: nil)
                    let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeViewController")
                    self?.navigationController?.setViewControllers([homeVC], animated: true)
                    print("user signed in\(String(describing: User.currentUser?.uid))")

                }
                else{
                    ProgressHUD.showError(error?.localizedDescription)
                }
            }
        }
        
    }
    

    
}

