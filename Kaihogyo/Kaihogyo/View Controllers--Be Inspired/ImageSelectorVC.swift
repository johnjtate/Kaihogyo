//
//  ImageSelectorVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/6/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

protocol ImageSelectorVCDelegate: class {
    
    func imageSelected(_ image: UIImage)
}

class ImageSelectorVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    weak var delegate: ImageSelectorVCDelegate?
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        selectImageButton.setTitle("Select a Photo", for: .normal)
        imageView.image = nil
    }
    
    // MARK: - IBActions
    @IBAction func selectImageButtonTapped(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
}

extension ImageSelectorVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImageButton.setTitle("", for: .normal)
            imageView.image = image
            delegate?.imageSelected(image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
