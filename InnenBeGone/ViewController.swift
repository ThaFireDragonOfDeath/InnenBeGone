//
//  ViewController.swift
//  InnenBeGone
//
//  Created by Marcel Gosmann on 25.07.21.
//

import Cocoa
import SafariServices.SFSafariApplication
import SafariServices.SFSafariExtensionManager

let appName = "InnenBeGone"
let extensionBundleIdentifier = "de.techdragonblog.InnenBeGone.Extension"

class ViewController: NSViewController {

    @IBOutlet var appNameLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appNameLabel.stringValue = appName
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: extensionBundleIdentifier) { (state, error) in
            guard let state = state, error == nil else {
                // Insert code to inform the user that something went wrong.
                return
            }

            DispatchQueue.main.async {
                if (state.isEnabled) {
                    self.appNameLabel.stringValue = "Erweiterung '\(appName)' ist derzeit aktiviert."
                } else {
                    self.appNameLabel.stringValue = "Erweiterung '\(appName)' ist derzeit deaktiviert. Sie können diese Erweiterung in Safari Einstellungen im Tab 'Erweiterungen' aktivieren."
                }
            }
        }
    }
    
    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: extensionBundleIdentifier) { error in
            guard error == nil else {
                // Insert code to inform the user that something went wrong.
                return
            }

            DispatchQueue.main.async {
                NSApplication.shared.terminate(nil)
            }
        }
    }

}
