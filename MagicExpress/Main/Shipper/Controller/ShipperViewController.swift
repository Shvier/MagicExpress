//
//  ShipperViewController.swift
//  MagicExpress
//
//  Created by Shvier on 02/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class ShipperViewController: NSViewController {

    @IBOutlet weak var checkButton: NSButton!
    @IBOutlet weak var cancelButton: NSButton!
    @IBOutlet weak var subscribeButton: NSButton!
    @IBOutlet weak var shipperPopUpButton: NSPopUpButton!
    @IBOutlet weak var shipperTextField: NSTextField!
    @IBOutlet var contentTextView: NSTextView!
    
    @IBAction func checkAction(_ sender: NSButton) {
        let shipperCode: String = shipperPopUpButton.titleOfSelectedItem!
        let logisticCode: String = shipperTextField.stringValue
        ShipperDataController.queryShipper(shipperCode: shipperCode, logisticCode: logisticCode, success: { [unowned self] (shipperModel) in
            var result: String = ""
            for trace in shipperModel.traces! {
                result += trace.acceptTime! + "\n" + trace.acceptStation! + "\n"
            }
            self.contentTextView.string = result
            if !ShipperTable.checkDataExistInShipper(logisticCode: logisticCode, shipperCode: shipperCode) {
                ShipperTable.insertShipper(shipper: shipperModel, failure: { (error) in
                    switch (error as NSError).code {
                    case 19:
                        print("duplicate data")
                    default:
                        print("error: \(error)")
                    }
                })
            } else {
                
            }		
        }) { (error) in
            switch (error as NSError).code {
            case 100404:
                print("data not found")
            default:
                print("error: \(error)")
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: NSButton) {
        dismissViewController(self)
    }
    
    @IBAction func subscribeAction(_ sender: NSButton) {
        let shipperCode: String = shipperPopUpButton.titleOfSelectedItem!
        let logisticCode: String = shipperTextField.stringValue
        ShipperDataController.subscribe(shipperCode: shipperCode, logisticCode: logisticCode, success: { [unowned self] (subscribeModel) in
            if !subscribeModel.result! {
                print("data not found")
            } else {
                self.dismissViewController(self)
            }
        }) { (error) in
            
        }
    }
    
    @IBAction func checkSelectedItemValid(_ sender: NSPopUpButton) {
        if sender.indexOfSelectedItem != 0 && shipperTextField.stringValue.lengthOfBytes(using: .utf8) != 0 {
            checkButton.isEnabled = true
            subscribeButton.isEnabled = true
        } else if sender.indexOfSelectedItem == 0 {
            checkButton.isEnabled = false
            subscribeButton.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        shipperTextField.delegate = self
        checkButton.isEnabled = false
        subscribeButton.isEnabled = false
        
        shipperPopUpButton.addItems(withTitles: ExpressTable.getExpressName())
    }

}

extension ShipperViewController: NSTextFieldDelegate {
    
    override func controlTextDidChange(_ obj: Notification) {
        if obj.object == nil {
            return
        } else {
            let textField = obj.object as! NSTextField
            let length = textField.stringValue.lengthOfBytes(using: .utf8)
            if length == 0 {
                checkButton.isEnabled = false
                subscribeButton.isEnabled = false
            } else if shipperPopUpButton.indexOfSelectedItem != 0 {
                checkButton.isEnabled = true
                subscribeButton.isEnabled = true
            }
        }
    }
    
}
