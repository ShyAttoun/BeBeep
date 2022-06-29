//
//  HomeViewController.swift
//  Bebeep
//
//  Created by shy attoun on 23/05/2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import ProgressHUD
import FirebaseDatabase
import FirebaseMessaging
import FirebaseStorage
import CoreMedia

class HomeViewController: UIViewController,UISearchBarDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var carNumberLbl: UILabel!
    @IBOutlet weak var searchBarCars: UISearchBar!
    @IBOutlet weak var MSGPicker: UIPickerView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendMessageBtn: UIButton!
 
    
    
    let quickMSGS = ["choose a quick message:","Lights are on","Blocking","Open window","report"]
    
    let db =  Firestore.firestore()
     
    var partnerId: String!
    var partnerUser: User!
    var isTyping =  false
    var timer = Timer ()
    var userDetails: [UserDetails] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        searchBarCars.delegate =  self
        MSGPicker.delegate = self
    
        
    }

    @IBAction func contactCarOwnerBtn(_ sender: UIButton) {
    
    }
    
    @IBAction func sendMessageBtnPressed(_ sender: UIButton) {
        
    
        if let text = messageTextView.text,text != "" {
            messageTextView.text = ""
            self.textViewDidChange(messageTextView)
            sendToFirebase(dict: ["text": text as Any])
        }
    }
    
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        signOutFromApp()
    }
    
    @objc func inboxButtonPressed(){
        let mainSB = UIStoryboard(name: "Main", bundle: nil)

        let inboxVC = mainSB.instantiateViewController(withIdentifier: "ChatViewController")
        self.navigationController?.setViewControllers([inboxVC], animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            
            self.carNumberLbl.text = ""
            print("searchbar is empty")
        }else {
            getDataSpecificField (carNumber: carNumberLbl.text!)
    }

    }
    
    
    func getDataSpecificField (carNumber: String){
        
        db.collection("Users").whereField("car_license", isEqualTo: self.searchBarCars.text!).limit(to: 1)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let carNumber = document.get("car_license") as! String
                        self.carNumberLbl.text =  carNumber
                        self.partnerId = document.get("uid") as! String
                    }
                }
        }
    }
    
    func sendToFirebase (dict: Dictionary<String, Any>) {
        let date: Double = Date().timeIntervalSince1970
        var value = dict
        value["from"] = Api.User.currentUserId
        value["to"] = partnerId
        value["date"] = date
        value["read"] =  false
        
        Api.Message.sendMessage(from: Api.User.currentUserId, to: partnerId, value: value)
                
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let spacing = CharacterSet.whitespacesAndNewlines
        if !textView.text.trimmingCharacters(in: spacing).isEmpty{
            _ = textView.text.trimmingCharacters(in: spacing)
            sendMessageBtn.isEnabled = true
            sendMessageBtn.setTitleColor(.black , for: UIControl.State.normal)
        } else {
           
            sendMessageBtn.setTitleColor(.lightGray, for: UIControl.State.normal)
        }
    }
    
    
    @objc func signOutFromApp () {
        let uid = Api.User.currentUserId
        do{

            try Auth.auth().signOut()
            Messaging.messaging().unsubscribe(fromTopic: uid)
            let mainSB = UIStoryboard(name: "Main", bundle: nil)

            let welcomeVC = mainSB.instantiateViewController(withIdentifier: "WelcomeViewController")
            self.navigationController?.setViewControllers([welcomeVC], animated: true)
        }catch {
            ProgressHUD.showError(error.localizedDescription)
        return
        }
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        quickMSGS.count

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        messageTextView.text = quickMSGS[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return quickMSGS[row]
    }
}


//let button = UIButton(type: .custom)
//               //set image for button
//               button.setImage(UIImage(named: "inbox"), for: .normal)
//               //add function for button
//               button.addTarget(self, action: #selector(inboxButtonPressed), for: .touchUpInside)
//               //set frame
//               button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
//
//               let barButton = UIBarButtonItem(customView: button)
//               //assign button to navigationbar
//               self.navigationItem.rightBarButtonItem = barButton
