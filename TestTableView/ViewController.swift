//
//  ViewController.swift
//  TestTableView
//
//  Created by Synergy on 20/06/2018.
//  Copyright © 2018 Synergy.com.nl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var loadingView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var offerTableView: UITableView!
    
    var countCell:Int? = nil
    var indexTable:Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("countCell = \(String(describing: countCell))")
        activityIndicator.color = UIColor(red: 11/255, green: 86/255, blue: 14/255, alpha: 1)
//        offerTableView.tableFooterView = loadingView

        prepareTableView()

    }
    
    func prepareTableView() {
        offerTableView.dataSource = self
        print("ViewController - \(OfferTableViewCell.ReuseIdentifier)")
        
        let nib = UINib(nibName: OfferTableViewCell.NibName, bundle: .main)
        offerTableView.register(nib, forCellReuseIdentifier: OfferTableViewCell.ReuseIdentifier)
    }
    
}


