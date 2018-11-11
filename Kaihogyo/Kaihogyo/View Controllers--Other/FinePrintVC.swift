//
//  FinePrintVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/11/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class FinePrintVC: UIViewController {

    // MARK: - Properties
    var privacyPolicyURL: String = "https://www.freeprivacypolicy.com/privacy/view/290d9d1df1097fbc30623437df3600ac"
    var url: URL?
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction func privacyPolicyButtonTapped(_ sender: Any) {
        guard let url = URL(string: privacyPolicyURL) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
