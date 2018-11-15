//
//  ModernMarathonVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/5/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class ModernMarathonVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var modernMarathonImageView: UIImageView!
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modernMarathonImageView.layer.cornerRadius = 10.0
        modernMarathonImageView.layer.masksToBounds = true
    }
}
