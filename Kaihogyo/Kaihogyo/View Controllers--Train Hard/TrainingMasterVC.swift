//
//  TrainingMasterVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/2/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class TrainingMasterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeHealthKit()
    }
    
    // authorize HealthKit the first time this view is loaded
    func authorizeHealthKit() {
     
        SetupHealthKit.authorizeHK { (authorized, error) in
            
            if authorized {
                print("HealthKit successfully authorized.")
                return
            }
            
            if let error = error {
                print("HealthKit authorization failed.  \(error.localizedDescription)")
                return
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
