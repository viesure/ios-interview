//
//  AppDelegate.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import UIKit
import SwURL
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        SwURL.setImageCache(type: .persistent)
        return true
    }
}
