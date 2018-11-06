//
//  InspirationDetailVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/5/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class InspirationDetailVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var inspirationItemText: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - Properties
    var image: UIImage?
    var inspirationItem: InspirationItem? {
        didSet {
            loadViewIfNeeded()
            updateView()
        }
    }
    
    func updateView() {
        if let caption = inspirationItem?.caption {
            inspirationItemText.text = caption
        }
    }
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImageSelectorVC" {
            guard let destinationVC = segue.destination as? ImageSelectorVC else { return }
            destinationVC.delegate = self
            if let image = inspirationItem?.image {
                destinationVC.existingItemImage = image
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let caption = inspirationItemText.text, let image = image, !caption.isEmpty else { return }
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

extension InspirationDetailVC: ImageSelectorVCDelegate {
    
    func imageSelected(_ image: UIImage) {
        self.image = image
    }
}
