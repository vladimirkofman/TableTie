//
//  ViewController.swift
//  Example
//
//  Created by Vladimir Kofman on 21/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import UIKit
import TableTie

struct Example {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
}

extension Example: Row {
    func configure(cell: UITableViewCell) {
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = text
    }
}

class ViewController: UITableViewController {
    
    let tieAdapter = Adapter()
    
    override func viewDidLoad() {
        tieAdapter.set([
            SelectableRow(Example("Custom Cells"), self.showExample("Ex1")),
            SelectableRow(Example("Storyboard cells"), self.showExample("Ex2")),
            ])
        
        tableView.delegate = tieAdapter
        tableView.dataSource = tieAdapter
        
        super.viewDidLoad()
    }
    
    func showExample(_ segueId: String) {
        performSegue(withIdentifier: segueId, sender: nil)
    }
}
