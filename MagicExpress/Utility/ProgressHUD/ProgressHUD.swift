//
//  ProgressHUD.swift
//  MagicExpress
//
//  Created by Shvier on 12/06/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

class ProgressHUD: NSView {

    let kMaxWidth = 250
    let kMaxHeight = 200
    
    var keepActivityCount: Bool?
    var animatingDimiss: Bool?
    var animatingShow: Bool?
    var displaying: Bool?
    var activityCount: UInt?
    
    var offset: CGVector = CGVector.zero
    var alpha: CGFloat = 0.9
    var padding: CGFloat = 10
    var indicatorSize: CGSize = CGSize(width: 40, height: 40)
    var indicatorOffset: CGVector = CGVector.zero
    var labelSize: CGSize?
    var labelOffset: CGVector?
    
    var parentView: NSView?
    var size: CGSize = CGSize.zero
    lazy var activityIndicator: ActivityIndicator = {
        return ActivityIndicator()
    }()
    var label: NSTextField = {
        return NSTextField()
    }()
    var backgroundMask: NSButton = {
        return NSButton()
    }()
    lazy var mainHUD: NSView = {
        return NSView()
    }()
    
    var backgroundAlpha: CGFloat = 0.4
    var actionsEnabled: Bool = false
    
    static let sharedInstance = ProgressHUD()
    
    static func showStatus(title: String, from view: NSView) {
        sharedInstance.showStatus(title: title, from: view)
    }
    
    static func setBackgroundAlpha(alpha: CGFloat, disabeActions: Bool) {

    }
    
    static func showProgress(progress: CGFloat, title: String, from view: NSView) {
        sharedInstance.showProgress(progress: progress, title: title, from: view)
    }
    
    static func dismiss() {

    }
    
    static func popActivity() {
        
    }
    
    func showStatus(title: String, from view: NSView) {
        parentView = view
        label.stringValue = title
        activityIndicator.isHidden = false
        activityIndicator.startAnimation()
        if !displaying! {
            
        }
    }
    
    func addMask() {
        
    }
    
    func remove() {
        
    }
    
    func showProgress(progress: CGFloat, title: String, from view: NSView) {
        
    }

    func replaceViewQuick() {
        
    }
    
    func beginShowView() {
        
    }
    
    func finishHideView() {
        
    }
    
    func showViewAnimated() {
        
    }
    
    func hideViewAnimated() {
        
    }
    
    func popActivity() {
        
    }
    
    func updateLayout() {
        
    }
    
    func setBackground() {
        let backgroundColor = CGColor(red: 0.05, green: 0.05, blue: 0.05, alpha: alpha)
        if !mainHUD.wantsLayer {
            let backgroundLayer = CALayer()
            backgroundLayer.backgroundColor = backgroundColor
            backgroundLayer.cornerRadius = 15.0
            mainHUD.wantsLayer = true
            mainHUD.layer = backgroundLayer
        } else {
            mainHUD.layer?.backgroundColor = backgroundColor
            mainHUD.layer?.cornerRadius = 15.0
        }
        //TODO
    }
    
    func height(string: String, font: NSFont, width: CGFloat) -> CGFloat {
        let textStorage = NSTextStorage(string: string)
        let textContainer = NSTextContainer(containerSize: NSSize(width: width, height: CGFloat(Float.greatestFiniteMagnitude)))
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textStorage.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, textStorage.length))
        textContainer.lineFragmentPadding = 0.0
        layoutManager.glyphRange(for: textContainer)
        return layoutManager.usedRect(for: textContainer).size.height
    }
    
    func center(inRect parentFrame: NSRect, scale: CGFloat) -> NSRect{
        var result: NSRect = NSRect.zero
        let newWidth = size.width*scale
        let newHeight = size.height*scale
        result.origin.x = parentFrame.size.width/2 - newWidth/2 + offset.dx
        result.origin.y = parentFrame.size.height/2 - newHeight/2 + offset.dy
        result.size.width = newWidth
        result.size.height = newHeight
        return result
    }
    
    func initializePopup() {
        autoresizingMask = [.viewMaxXMargin, .viewMaxYMargin, .viewMinXMargin, .viewMinYMargin]
        mainHUD.autoresizingMask = [.viewMaxXMargin, .viewMaxYMargin, .viewMinXMargin, .viewMinYMargin]
        addSubview(mainHUD)
        mainHUD.addSubview(label)
        mainHUD.addSubview(activityIndicator)
        label.isBezeled = false
        label.drawsBackground = false
        label.isEditable = false
        label.isSelectable = false
        label.font = NSFont.boldSystemFont(ofSize: 12.0)
        label.textColor = NSColor(calibratedWhite: 1.0, alpha: 0.85)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
