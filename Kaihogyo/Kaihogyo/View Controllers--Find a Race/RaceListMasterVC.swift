//
//  RaceListMasterVC.swift
//  Kaihogyo
//
//  Created by John Tate on 11/1/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class RaceListMasterVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var racesMasterTableView: UITableView!
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        racesMasterTableView.dataSource = self
        racesMasterTableView.delegate = self
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RaceController.shared.races.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = racesMasterTableView.dequeueReusableCell(withIdentifier: "raceCell", for: indexPath) as? RaceMasterListCell
        let race = RaceController.shared.races[indexPath.row]
        cell?.race = race
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
