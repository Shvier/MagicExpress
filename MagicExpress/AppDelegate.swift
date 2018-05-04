//
//  AppDelegate.swift
//  MagicExpress
//
//  Created by Shvier on 15/04/2017.
//  Copyright © 2017 Shvier. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem?
    var shareMenu: NSMenu?
    var popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        statusItem = NSStatusBar.system.statusItem(withLength: -2)
        if let button = statusItem?.button {
            button.image = NSImage(named: NSImage.Name(rawValue: "resizeApi"))
            button.action = #selector(AppDelegate.itemAction(item:))
        }
        shareMenu = NSMenu(title: "菜单")
        shareMenu?.addItem(NSMenuItem(title: "选项一", action: #selector(AppDelegate.showAction(item:)), keyEquivalent: "P"))
        shareMenu?.addItem(NSMenuItem(title: "选项二", action: #selector(AppDelegate.exitAction(item:)), keyEquivalent: "Q"))
        
        popover.contentViewController = PopoverViewController(nibName: NSNib.Name(rawValue: "PopoverViewController"), bundle: nil)
        
        register()
        if !UserManager.isLogin() {
            register()
        } else {
            update()
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func showPopover(sender: AnyObject?) {
        popover.show(relativeTo: (statusItem?.button?.bounds)!, of: (statusItem?.button)!, preferredEdge: NSRectEdge.minY)
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
    }
    
    func itemAction(item: NSStatusItem) {
        if popover.isShown {
            closePopover(sender: item)
        } else {
            showPopover(sender: item)
        }
    }
    
    func showAction(item: NSMenuItem) {
        
    }
    
    func exitAction(item: NSMenuItem) {
        
    }
    
    func register() {
        UserAPIService.register(userid: SystemManger.uuid(), success: { (userInfoAPIModel) in
            
        }) { (error) in
            
        }
    }
    
    func update() {
        
    }
    
}
