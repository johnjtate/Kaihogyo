//
//  LoginVC.swift
//  Kaihogyo
//
//  Created by John Tate on 10/31/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(segueToTabBarVC), name: UserController.shared.currentUserWasSetNotification, object: nil)
    }
    
    // MARK: - Helper Functions
    @objc func segueToTabBarVC() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toTabBarVC", sender: self)
        }
    }
    
    // MARK: - Alert Controller
    func presentSignUpAlertController() {
        
        let signUpAlertController = UIAlertController(title: "Sign Up for Kaihogyo", message: "Please enter your email address and a username below.", preferredStyle: .alert)
        signUpAlertController.addTextField { (emailTextField) in
            emailTextField.placeholder = "Email address"
        }
        signUpAlertController.addTextField { (userNameTextField) in
            userNameTextField.placeholder = "Username"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let signUpAction = UIAlertAction(title: "Sign Up", style: .default) { (_) in
            
            guard let emailAddress = signUpAlertController.textFields?.first?.text, let username = signUpAlertController.textFields?[1].text, !emailAddress.isEmpty, !username.isEmpty else { return }
            UserController.shared.createUserWith(username: username, email: emailAddress, completion: { (success) in
                
                if success {
                    self.segueToTabBarVC()
                } else {
                    DispatchQueue.main.async {
                        self.presentAlertControllerWith(title: "Whoops--something went wrong", message: "Please make sure you are logged into iCloud in your phone settings.")
                    }
                }
            })
        }
        signUpAlertController.addAction(cancelAction)
        signUpAlertController.addAction(signUpAction)
        self.present(signUpAlertController, animated: true)
    }
    
    // MARK: - IBActions
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        presentSignUpAlertController()
    }
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        
        guard UserController.shared.currentUser == nil else {
            segueToTabBarVC()
            return
        }
        
        // if not a current user, then fetch
        UserController.shared.fetchCurrentUser { (success) in
            
            if !success {
                DispatchQueue.main.async {
                    self.presentAlertControllerWith(title: "No iCloud account configured", message: "Please sign into your iCloud account.")
                }
            }
        }
    }
}
