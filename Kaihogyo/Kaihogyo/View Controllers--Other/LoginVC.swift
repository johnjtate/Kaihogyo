//
//  LoginVC.swift
//  Kaihogyo
//
//  Created by John Tate on 10/31/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit
import CloudKit

class LoginVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var amphoraImageView: UIImageView!
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amphoraImageView.layer.cornerRadius = 10.0
        amphoraImageView.layer.masksToBounds = true
    }
    
    // MARK: - Helper Functions
    @objc func segueToTabBarVC() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toTabBarVC", sender: self)
        }
    }
    
    // MARK: - Alert Controllers
    
    func presentErrorAlert(errorTitle: String, errorMessage: String) {
       
        let errorAlertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        let goToSettingsAction = UIAlertAction(title: "Go to Settings", style: .default) { (_) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        errorAlertController.addAction(goToSettingsAction)
        self.present(errorAlertController, animated: true)
    }
    
    // MARK: - CloudKit Availability
    
    func checkAccountStatus(completion: @escaping (_ isLoggedIn: Bool) -> Void) {
        
        CKContainer.default().accountStatus { [weak self] (status, error) in
            if let error = error {
                print("Error checking account status \(error) \(error.localizedDescription)")
                completion(false); return
            } else {
                let errorText = "Sign into iCloud in Settings"
                switch status {
                case .available:
                    completion(true)
                case .noAccount:
                    let noAccount = "No iCloud account found"
                    self?.presentErrorAlert(errorTitle: errorText, errorMessage: noAccount)
                    completion(false)
                case .couldNotDetermine:
                    self?.presentErrorAlert(errorTitle: errorText, errorMessage: "Error with iCloud account status")
                    completion(false)
                case .restricted:
                    self?.presentErrorAlert(errorTitle: errorText, errorMessage: "Restricted iCloud account")
                    completion(false)
                }
            }
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func logInButtonTapped(_ sender: Any) {
        
        checkAccountStatus { (success) in
            if success {
                self.segueToTabBarVC()
            }
        }
    }
}

