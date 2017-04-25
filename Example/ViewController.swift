//
//  ViewController.swift
//  Example
//
//  Created by Vladimir Kofman on 21/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import UIKit
import TableTie

extension String: Row {
    public func configure(cell: UITableViewCell) {
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = self
    }
}

class ViewController: UITableViewController {
    
    let tieAdapter = Adapter()
    
    override func viewDidLoad() {
        tieAdapter.set([
            SelectableRow("Custom Cells", self.showExample("Ex1")),
            SelectableRow("Storyboard Cells", self.showExample("Ex2")),
            ])
        
        tableView.delegate = tieAdapter
        tableView.dataSource = tieAdapter
        
        super.viewDidLoad()
    }
    
    func showExample(_ segueId: String) {
        performSegue(withIdentifier: segueId, sender: nil)
    }
}
