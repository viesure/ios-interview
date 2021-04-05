//
//  ExecutionEnvironment.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

class ExecutionEnvironment {
    static func isUITesting() -> Bool {
        return ProcessInfo().environment["isUITesting"] != nil
    }
}
