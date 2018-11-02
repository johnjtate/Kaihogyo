//
//  InspiredMasterVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/2/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class InspiredMasterVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var runningQuotesButton: UIButton!
    @IBOutlet weak var inspirationWallButton: UIButton!
    @IBOutlet weak var theFirstMarathonButton: UIButton!
    @IBOutlet weak var theMarathonMonksButton: UIButton!
    @IBOutlet weak var theMarathonInModernTimesButton: UIButton!
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonLayout()
    }
    
    // MARK: - Layout Functions
    
    func updateButtonLayout() {
        
        // set alpha of background images to 0.3
        runningQuotesButton.imageView?.alpha = 0.3
        inspirationWallButton.imageView?.alpha = 0.3
        theFirstMarathonButton.imageView?.alpha = 0.3
        theMarathonMonksButton.imageView?.alpha = 0.3
        theMarathonInModernTimesButton.imageView?.alpha = 0.3
        
        // set rounded corners
        runningQuotesButton.layer.cornerRadius = 10.0
        runningQuotesButton.layer.masksToBounds = true
        inspirationWallButton.layer.cornerRadius = 10.0
        inspirationWallButton.layer.masksToBounds = true
        theFirstMarathonButton.layer.cornerRadius = 10.0
        theFirstMarathonButton.layer.masksToBounds = true
        theMarathonMonksButton.layer.cornerRadius = 10.0
        theMarathonMonksButton.layer.masksToBounds = true
        theMarathonInModernTimesButton.layer.cornerRadius = 10.0
        theMarathonInModernTimesButton.layer.masksToBounds = true
        
        
    }
    

}
