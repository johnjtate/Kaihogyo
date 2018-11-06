//
//  InspirationItemCell.swift
//  Kaihogyo
//
//  Created by John Tate on 11/5/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class InspirationItemCell: UICollectionViewCell {
 
    // MARK: - IBOutlets
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTextLabel: UILabel!
    
    // MARK: - Properties
    
    var item: InspirationItem? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let item = item else { return }
        
        cellTextLabel.text = item.caption
        cellImageView.image = item.image
        
        cellImageView.layer.masksToBounds = true
        cellImageView.layer.cornerRadius = 5.0
    }
}
