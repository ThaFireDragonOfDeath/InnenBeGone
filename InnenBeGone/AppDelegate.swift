//
//  AppDelegate.swift
//  InnenBeGone
//
//  Created by Marcel Gosmann on 25.07.21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
