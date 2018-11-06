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
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - Properties
    var inspirationItem: InspirationItem? {
        didSet {
            loadViewIfNeeded()
            updateView()
        }
    }
    
    func updateView() {
        if let image = inspirationItem?.image {
            inspirationItemImage.image = image
        }
        if let caption = inspirationItem?.caption {
            inspirationItemText.text = caption
        }
    }
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // TODO: save function
    // TODO: photo picker
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let caption = inspirationItemText.text, let image = inspirationItemImage.image else { return }
        // if existing item was passed by segue and updating item
        if let item = inspirationItem {
            
            InspirationItemController.shared.updateEntry(item: item, caption: caption, image: image) { (success) in
                if success {
                    print("success updating item")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    print("failure updating item")
                }
            }
            
        // if creating new item
        } else {

            InspirationItemController.shared.createInspirationItemWith(caption: caption, image: image) { (item) in
           
                if item != nil {
                    print("success creating new item")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    print("failure creating new item")
                }
            }
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
        if let item = inspirationItem {
            InspirationItemController.shared.deleteItem(item: item) { (success) in
                if success {
                    print("success deleting entry")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    print("failure deleting entry")
                }
            }
        }
    }
}
