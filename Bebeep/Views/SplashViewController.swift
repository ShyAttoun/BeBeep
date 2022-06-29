//
//  SplashViewController.swift
//  Bebeep
//
//  Created by shy attoun on 23/05/2022.
//

import Foundation
import UIKit
import CLTypingLabel
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import ProgressHUD
import FirebaseDatabase
import FirebaseMessaging
import FirebaseStorage


class SplashViewController: UIViewController {
    
    @IBOutlet weak var logoAnimationLabel: CLTypingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        logoAnimationLabel.text = "Be" + "Beep"
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.checkIfUserLoggedIn()
            
        }
    }
    
    func checkIfUserLoggedIn () {

        
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            
            let mainSB = UIStoryboard(name: "Main", bundle: nil)

              if let CurrentUser = user {
                // User is signed in.
                  let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeViewController")
                  self?.navigationController?.setViewControllers([homeVC], animated: true)
                  print("user signed in\(CurrentUser.uid)")
                
              } else {
                  let welcomeVC = mainSB.instantiateViewController(withIdentifier: "WelcomeViewController")
                  self?.navigationController?.setViewControllers([welcomeVC], animated: true)
                  print("user is not signed in")
                
              }
            }
    }
}
