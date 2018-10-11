//
//  Ex1.swift
//  TableTie
//
//  Created by Vladimir Kofman on 21/04/2017.
//  Copyright © 2017 Vladimir Kofman. All rights reserved.
//

import UIKit
import TableTie

//MARK: - Models
/**
    Here we have sample models for Songs and Albums.
    The model can be anything: struct, class, enum or just String.
    So you can simply use your existing models 😎
 */
struct Song {
    let title: String
}

struct Album {
    let name: String
    let artist: String
}

//MARK: - Custom cells for the above models
/**
    Those are just regular UITableViewCells.
    I'm using a simple customization here in order to keep the example simple,
    But you can customize it as you wish 🎨
 */
class SongCell: UITableViewCell {}

class AlbumCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Model extensions
/**
    Here we need to tie our models in with the cells:
    Extend the model to conform to TableTie.Row protocol.
    The only required func is configure(cell:)
    cell parameter should receive the customized cell type we've defined earlier.
    So your job in this func is to tie your model in with the cell.
    That's all! 🏆
 */
extension Song: Row {
    func configure(cell: SongCell) {
        cell.textLabel?.text = title
    }
}

extension Album: Row {
    func configure(cell: AlbumCell) {
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = artist
    }
}

//MARK: - Example

class Ex1: UITableViewController {
    
    let tieAdapter = Adapter([
        Section("Album", [
            Album(name: "Paranoid", artist:"Black Sabbath"),
        ]),
        Section("Side one", [
            Song(title: "War Pigs"),
            Song(title: "Paranoid"),
            Song(title: "Planet Caravan"),
            Song(title: "Iron Man"),
        ]),
        Section("Side two", [
            Song(title: "Electric Funeral"),
            Song(title: "Hand of Doom"),
            Song(title: "Rat Salad"),
            Song(title: "Fairies Wear Boots"),
            ]),
    ])
    
    override func viewDidLoad() {
     
        /**
            Don't forget to set tableView.delegate & tableView.dataSource
         */
        tableView.delegate = tieAdapter
        tableView.dataSource = tieAdapter
      
        super.viewDidLoad()
    }
}
