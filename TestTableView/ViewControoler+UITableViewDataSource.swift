//
//  ViewControoler+UITableViewDataSource.swift
//  TestTableView
//
//  Created by Synergy on 20/06/2018.
//  Copyright © 2018 Synergy.com.nl. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OfferTableViewCell.ReuseIdentifier) as! OfferTableViewCell
        cell.load()
        countCell = indexPath.row
        print("countCell = \(String(describing: countCell))")

        return cell
        
    }
    
}
