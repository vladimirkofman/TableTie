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
    let didSelect: ()->Void
    
    init(_ text: String, _ didSelect: @escaping @autoclosure ()->Void) {
        self.text = text
        self.didSelect = didSelect
    }
}

extension Example: Row {
    func configure(cell: UITableViewCell) {
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "Example \(text)"
    }
    
    func didSelectRow(of tableView: UITableView, at indexPath: IndexPath) {
        self.didSelect()
    }
}

class ViewController: UITableViewController {
    
    let tieAdapter = Adapter()
    
    override func viewDidLoad() {
        tieAdapter.set([
            Example("One", self.performSegue(withIdentifier: "Ex1", sender: nil)),
            Example("Two", self.performSegue(withIdentifier: "Ex1", sender: nil)),
            Example("Three", self.performSegue(withIdentifier: "Ex1", sender: nil)),
            ])
        
        tableView.delegate = tieAdapter
        tableView.dataSource = tieAdapter
        
        super.viewDidLoad()
    }
    
    func showExample(_ segueId: String) {
        performSegue(withIdentifier: segueId, sender: nil)
    }
}
