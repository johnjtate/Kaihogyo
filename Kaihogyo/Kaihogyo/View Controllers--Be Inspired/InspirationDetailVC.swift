//
//  InspirationDetailVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/5/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class InspirationDetailVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var inspirationItemImage: UIImageView!
    @IBOutlet weak var inspirationItemText: UITextView!
    
    // MARK: - Properties
    var inspirationItem: InspirationItem? {
        didSet {
            loadViewIfNeeded()
            updateView()
        }
    }
    
    func updateView() {
        if let imageData = inspirationItem?.imageData {
            inspirationItemImage.image = UIImage(data: imageData)
        }
        if let text = inspirationItem?.text {
            inspirationItemText.text = text
        }
    }
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // TODO: save function
    // TODO: photo picker
    
}
