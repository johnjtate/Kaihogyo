//
//  MarathonMonksVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/5/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class MarathonMonksVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var japaneseMountainImageView: UIImageView!
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        japaneseMountainImageView.layer.cornerRadius = 10.0
        japaneseMountainImageView.layer.masksToBounds = true
    }
}
