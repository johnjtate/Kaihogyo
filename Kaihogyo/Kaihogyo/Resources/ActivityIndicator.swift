//
//  ActivityIndicator.swift
//  Kaihogyo
//
//  Created by John Tate on 11/1/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicator {
    private init() {}
    
    static let shared = ActivityIndicator()
   
    let activityLabel = UILabel(frame: CGRect(x: 24, y: 0, width: 0, height: 0))
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let activityView = UIView()
    
    func animateActivity(title: String, view: UIView, navigationItem: UINavigationItem) {
        
        guard navigationItem.titleView == nil else { return }
        activityIndicator.style = .gray
        activityLabel.text = title
        activityLabel.sizeToFit()
        let xPoint = view.frame.midX
        let yPoint = navigationItem.accessibilityFrame.midY
        let widthForActivityView = activityLabel.frame.width + activityIndicator.frame.width
        activityView.frame = CGRect(x: xPoint, y: yPoint, width: widthForActivityView, height: 30)
        
        activityLabel.center.y = activityView.center.y
        activityIndicator.center.y = activityView.center.y
        
        activityView.addSubview(activityIndicator)
        activityView.addSubview(activityLabel)
        
        navigationItem.titleView = activityView
        activityIndicator.startAnimating()
    }
    
    func stopAnimating(navigationItem: UINavigationItem) {
        activityIndicator.stopAnimating()
        navigationItem.titleView = nil
    }
}
