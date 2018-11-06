//
//  InspirationWallVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/5/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class InspirationWallVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - IBOutlet
    @IBOutlet weak var inspirationCollectionView: UICollectionView!
    
    // MARK: - Set Up Navigation Bar
    func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        self.performSegue(withIdentifier: "toInspirationDetailView", sender: self)
    }
    
    // MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        InspirationItemController.shared.fetchItems { (success) in
            if success {
                DispatchQueue.main.async {
                    self.inspirationCollectionView.reloadData()
                }
            }
        }
        inspirationCollectionView.dataSource = self
        inspirationCollectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inspirationCollectionView.reloadData()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInspirationDetailView" {
            let destinationVC = segue.destination as? InspirationDetailVC
            guard let indexPath = inspirationCollectionView.indexPathsForSelectedItems?.first else { return }
            let inspirationItem = InspirationItemController.shared.inspirationItems[indexPath.row]
            destinationVC?.inspirationItem = inspirationItem
        }
    }

    // MARK: - UICollectionView Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return InspirationItemController.shared.inspirationItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = inspirationCollectionView.dequeueReusableCell(withReuseIdentifier: "inspirationItemCell", for: indexPath) as? InspirationItemCell
        
        let inspirationItem = InspirationItemController.shared.inspirationItems[indexPath.row]
        cell?.item = inspirationItem
        cell?.layer.masksToBounds = true
        cell?.layer.cornerRadius = 10.0
        return cell ?? UICollectionViewCell()
    }
}
