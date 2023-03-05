//
//  FindMyIPApp.swift
//  FindMyIP
//
//  Created by Praveen on 05/03/23.
//

import SwiftUI

@main
struct FindMyIPApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    static private(set) var instance: AppDelegate!
    lazy var statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    let menu = ApplicationMenu()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        AppDelegate.instance = self
        
        statusBarItem.button?.title = "IP"
        statusBarItem.menu = menu.createMenu()
    }
}

