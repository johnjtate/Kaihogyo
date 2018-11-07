//
//  InspirationDetailVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/5/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class InspirationDetailVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var inspirationItemText: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - Properties
    var image: UIImage? {
        didSet {
            inspirationItem?.image = image
        }
    }
    var inspirationItem: InspirationItem? {
        didSet {
            loadViewIfNeeded()
            inspirationItemText.text = inspirationItem?.caption
        }
    }
    var updating: Bool = false
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inspirationItemText.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(InspirationDetailVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(InspirationDetailVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(updating)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
    
    // MARK: - Keyboard Functions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
   
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        inspirationItemText.resignFirstResponder()
        return true
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
        
        inspirationItemText.resignFirstResponder()
        
        guard let caption = inspirationItemText.text else { return }
        
        // if existing item was passed by segue and updating item
        if updating {
        
            guard let item = inspirationItem else { return }
            guard let image = inspirationItem?.image else { return }
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
        } else if !updating {

            guard let image = image else { return }
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
        
        // dismiss the keyboard if needed
        resignFirstResponder()
        
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
