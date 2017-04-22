//
//  Ex2.swift
//  TableTie
//
//  Created by Vladimir Kofman on 21/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import UIKit
import TableTie

struct Song2 {
    let title: String
}

struct Album2 {
    let name: String
    let artist: String
}

class AlbumCell2: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var artist: UILabel!
}

class SongCell2: UITableViewCell {
    @IBOutlet weak var title: UILabel!
}


extension Album2: Row {
    
    var reuseIdentifier: String { return "albumCell2" }
    var rowHeight: CGFloat { return 100.0 }
    
    func configure(cell: AlbumCell2) {
        cell.title.text = name
        cell.artist.text = artist
    }
}

extension Song2: Row {
    
    var reuseIdentifier: String { return "songCell2" }
    var rowHeight: CGFloat { return 60.00 }
    
    func configure(cell: SongCell2) {
        cell.title.text = title
    }
}

class Ex2: UITableViewController {
    
    let tieAdapter = Adapter([
        Album2(name: "Paranoid", artist:"Black Sabbath"),
        Song2(title: "War Pigs"),
        Song2(title: "Paranoid"),
        Song2(title: "Planet Caravan"),
        Song2(title: "Iron Man"),
        Song2(title: "Electric Funeral"),
        Song2(title: "Hand of Doom"),
        Song2(title: "Rat Salad"),
        Song2(title: "Fairies Wear Boots"),
        ])

    
    override func viewDidLoad() {
        
        tableView.dataSource = tieAdapter
        tableView.delegate = tieAdapter
        
        super.viewDidLoad()
    }
}
