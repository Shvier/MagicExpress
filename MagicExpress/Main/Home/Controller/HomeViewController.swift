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
    @IBOutlet weak var shipperPopUpButton: NSPopUpButton!
    
    var shippers: Array<ShipperModel>?
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func filterTableViewAction(_ sender: NSPopUpButton) {
        
    }
    
    @IBAction func addButtonAction(_ sender: NSButton) {
        let shipperVC = ShipperViewController(nibName: "ShipperViewController", bundle: nil)
        self.presentViewControllerAsSheet(shipperVC!)
    }
    
    @IBAction func refreshButtonAction(_ sender: NSButton) {

    }
    
    @IBAction func editButtonAction(_ sender: NSButton) {
        
    }
    
    @IBAction func historyButtonAction(_ sender: NSButton) {
        
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
        shippers = ShipperTable.getShippers()
        var shipperCodes = Array<String>()
        for shipper in shippers! {
            shipperCodes.append(shipper.shipperCode!)
        }
        shipperPopUpButton.addItems(withTitles: shipperCodes)
        tableView.reloadData()
        shipperPopUpButton.menu?.addItem(NSMenuItem.separator())
    }
    
    func heightForCell(content: String) -> CGFloat {
        let contentString: NSString = content as NSString
        let bounds = contentString.boundingRect(with: NSSize(width: 240, height: 0), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSFontAttributeName: NSFont.systemFont(ofSize: 13)])
        return bounds.size.height
    }
    
}

extension HomeViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        let shipperDetailVC = ShipperDetailViewController(nibName: "ShipperDetailViewController", bundle: nil)
        var result = ""
        for trace in (shippers?[row].traces)! {
            result += trace.acceptStation! + "\n"
        }
        shipperDetailVC?.content = result
        self.presentViewControllerAsSheet(shipperDetailVC!)
        return true
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return shippers == nil ? 0 : (shippers?.count)!
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return heightForCell(content: (shippers?[row].traces?.last?.acceptStation)!)
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var reuse = ""
        if (tableColumn?.isEqual(to: tableView.tableColumns[0]))! {
            reuse = "CellID1"
            if let cell = tableView.make(withIdentifier: reuse, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = (shippers?[row].traces?.last?.shipperCode)!
                cell.textField?.frame = CGRect(x: 0, y: 0, width: (cell.textField?.frame.size.width)!, height: heightForCell(content: (shippers?[row].traces?.last?.shipperCode)!))
                return cell
            }
        } else if (tableColumn?.isEqual(to: tableView.tableColumns[1]))! {
            reuse = "CellID2"
            if let cell = tableView.make(withIdentifier: reuse, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = (shippers?[row].traces?.last?.logisticCode)!
                cell.textField?.frame = CGRect(x: 0, y: 0, width: (cell.textField?.frame.size.width)!, height: heightForCell(content: (shippers?[row].traces?.last?.logisticCode)!))
                return cell
            }
        } else if (tableColumn?.isEqual(to: tableView.tableColumns[2]))! {
            reuse = "CellID3"
            if let cell = tableView.make(withIdentifier: reuse, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = (shippers?[row].traces?.last?.acceptStation)!
                cell.textField?.frame = CGRect(x: 0, y: 0, width: (cell.textField?.frame.size.width)!, height: heightForCell(content: (shippers?[row].traces?.last?.acceptStation)!))
                return cell
            }
        } else if (tableColumn?.isEqual(to: tableView.tableColumns[3]))! {
            reuse = "CellID4"
            if let cell = tableView.make(withIdentifier: reuse, owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = (shippers?[row].traces?.last?.acceptTime)!
                cell.textField?.frame = CGRect(x: 0, y: 0, width: (cell.textField?.frame.size.width)!, height: heightForCell(content: (shippers?[row].traces?.last?.acceptTime)!))
                return cell
            }
        }
        return nil
    }

}
