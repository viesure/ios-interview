//
//  ConnectivityViewModel.swift
//  viesure_iOS_interview
//
//  Created by Primoz Cuvan on 23.04.21.
//  Copyright © 2021 Primoz Cuvan. All rights reserved.
//

import Foundation
import SwiftUI
import Network

class ConnectivityViewModel: ObservableObject {
    let monitor = NWPathMonitor()
    @Published var showingConnectivityProblemsAlert = false
    
    init() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
            } else {
                print("No connection.")
                self.showingConnectivityProblemsAlert = true
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    
    func connectivityProblemsAlert() -> Alert {
        return Alert(
            title: Text("No Internet Connection"),
            message: Text("Connect to the internet to see the latest available articles."),
            dismissButton: .default(Text("OK")))
    }
}
