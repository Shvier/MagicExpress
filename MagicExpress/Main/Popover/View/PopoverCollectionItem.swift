//
//  PopoverCollectionItem.swift
//  MagicExpress
//
//  Created by Shvier on 15/04/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

let PopoverCollectionItemReuseIdentifier = "PopoverCollectionItemReuseIdentifier"

class PopoverCollectionItem: NSCollectionViewItem {
        
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        initUI()
    }
    
    func initUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension PopoverCollectionItem: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return "tableView"
    }
    
}
