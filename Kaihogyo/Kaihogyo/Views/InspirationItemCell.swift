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
            if let imageData = item?.imageData {
                cellImageView.image = UIImage(data: imageData)
            }
            if let text = item?.text {
                cellTextLabel.text = text
            }
        }
    }
}
