//
//  startupLaunch.swift
//  clipboard
//
//  Created by Jopaul Joy on 14/12/24.
//

import Foundation

func addAppToLoginItems() {
    let appPath = Bundle.main.bundlePath
        let launchAgentsDir = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library/LaunchAgents")
        
        // Ensure the LaunchAgents directory exists
        if !FileManager.default.fileExists(atPath: launchAgentsDir.path) {
            do {
                try FileManager.default.createDirectory(at: launchAgentsDir, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating LaunchAgents directory: \(error)")
                return
            }
        }
        
        let plistPath = launchAgentsDir.appendingPathComponent("jopauljoy.clipboard.startup.plist")
        
        // Check if the plist already exists
        if !FileManager.default.fileExists(atPath: plistPath.path) {
            let plistContent: [String: Any] = [
                "Label": "jopauljoy.clipboard.startup",
                "ProgramArguments": [appPath],
                "RunAtLoad": true
            ]
            
            // Serialize the plist content into XML
            do {
                let plistData = try PropertyListSerialization.data(fromPropertyList: plistContent, format: .xml, options: 0)
                try plistData.write(to: plistPath)
            } catch {
                print("Error writing plist data: \(error)")
            }
        }
    }
