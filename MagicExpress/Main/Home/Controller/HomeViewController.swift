//
//  HomeViewController.swift
//  MagicExpress
//
//  Created by Shvier on 15/04/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class HomeViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var addButton: NSButton!
    @IBOutlet weak var refreshButton: NSButton!
    @IBOutlet weak var editButton: NSButton!
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let notification = NSUserNotification()
        notification.title = "测试本地推送"
        notification.informativeText = "推送的内容"
        notification.actionButtonTitle = "查看"
        notification.soundName = NSUserNotificationDefaultSoundName
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { 
            NSUserNotificationCenter.default.scheduleNotification(notification)
        }
    }
    
    @IBAction func addButtonAction(_ sender: NSButton) {
        let shipperVC = ShipperViewController(nibName: "ShipperViewController", bundle: nil)
        self.presentViewControllerAsSheet(shipperVC!)
    }
    
    @IBAction func refreshButtonAction(_ sender: NSButton) {
        
    }
    
    @IBAction func editButtonAction(_ sender: NSButton) {
        
    }
    
}

extension HomeViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if (tableColumn?.isEqual(to: tableView.tableColumns[0]))! {
            return "顺丰"
        } else if (tableColumn?.isEqual(to: tableView.tableColumns[1]))! {
            return "123456"
        } else if (tableColumn?.isEqual(to: tableView.tableColumns[2]))! {
            return "已签收"
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var reuse = ""
        if (tableColumn?.isEqual(to: tableView.tableColumns[0]))! {
            reuse = "CellID1"
            if let cell = tableView.make(withIdentifier: reuse, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = "顺丰速运"
                return cell
            }
        } else if (tableColumn?.isEqual(to: tableView.tableColumns[1]))! {
            reuse = "CellID2"
            if let cell = tableView.make(withIdentifier: reuse, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = "123456789"
                return cell
            }
        } else if (tableColumn?.isEqual(to: tableView.tableColumns[2]))! {
            reuse = "CellID3"
            if let cell = tableView.make(withIdentifier: reuse, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = "派送中"
                return cell
            }
        }

        return nil
    }

}
