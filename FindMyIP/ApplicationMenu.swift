//
//  ApplicationMenu.swift
//  FindMyIP
//
//  Created by Praveen on 05/03/23.
//

import Foundation
import SwiftUI

class ApplicationMenu: NSObject {
    let menu = NSMenu()
    
    func createMenu() -> NSMenu {
        let contentView = ContentView()
        let topView = NSHostingController(rootView: contentView)
        topView.view.frame.size = CGSize(width: 200, height: 100)
        
        let customMenuItem = NSMenuItem()
        customMenuItem.view = topView.view
        menu.addItem(customMenuItem)
        //menu.addItem(NSMenuItem.separator())
        
        // About menu item
        let aboutMenuItem = NSMenuItem(title: "About FindMyIP", action: #selector(about), keyEquivalent: "")
        aboutMenuItem.target = self
        menu.addItem(aboutMenuItem)
        
        // Quit menu item
        let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q")
        quitMenuItem.target = self
        menu.addItem(quitMenuItem)
        
        
        return menu
    }
    
    @objc func about(sender: NSMenuItem) {
        NSApp.orderFrontStandardAboutPanel()
    }
    
    @objc func quit(sender: NSMenuItem) {
        NSApp.terminate(sender)
    }
}
