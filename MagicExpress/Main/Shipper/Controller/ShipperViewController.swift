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
        ShipperAPIService.queryShipper(shipperCode: shipperCode, logisticCode: logisticCode, success: { (shipperResultModel) in
            var result: String = ""
            for trace in shipperResultModel.traces {
                result += trace.acceptTime! + "\n" + trace.acceptStation! + "\n"
            }
            self.contentTextView.string = result
        }) { (error) in
            
        }
    }
    
    @IBAction func cancelAction(_ sender: NSButton) {
        dismissViewController(self)
    }
    
    @IBAction func subscribeAction(_ sender: NSButton) {
        let shipperCode: String = shipperPopUpButton.titleOfSelectedItem!
        let shipperText: String = shipperTextField.stringValue
        print("\(shipperCode)+\(shipperText)")
        dismissViewController(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        shipperTextField.delegate = self
        checkButton.isEnabled = false
        subscribeButton.isEnabled = false
        contentTextView.string = "12\n3i\n9\noj\na\nsd\nm.,,./sdf,pa\ns\n9\n0\na\nsd\nf\na\ns\nd\nf\nw\nro"
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
            } else {
                checkButton.isEnabled = true
                subscribeButton.isEnabled = true
            }
        }
    }
    
}
