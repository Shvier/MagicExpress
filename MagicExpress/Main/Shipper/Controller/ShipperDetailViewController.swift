//
//  ShipperDetailViewController.swift
//  MagicExpress
//
//  Created by Shvier on 09/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class ShipperDetailViewController: NSViewController {
    
    var content: String?

    @IBOutlet var contentTextView: NSTextView!
    
    @IBAction func confirmAction(_ sender: NSButton) {
        dismissViewController(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        contentTextView.string = content!
    }
    
}
