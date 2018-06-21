//
//  OfferTableViewCell.swift
//  TestTableView
//
//  Created by Synergy on 20/06/2018.
//  Copyright © 2018 Synergy.com.nl. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {
//
//    @IBOutlet weak var offerImageView: UIImageView!
//    @IBOutlet weak var offerTitleLabel: UILabel!
    

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLabel: UILabel!
    
    static let ReuseIdentifier = String(describing: OfferTableViewCell.self)
    static let NibName = String(describing: OfferTableViewCell.self)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func load() {

        offerTitleLabel.text = "Buzoianu Stefan"
    }
    
    

}
