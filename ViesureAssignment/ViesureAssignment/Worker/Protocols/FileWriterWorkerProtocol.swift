//
//  FileWritingWorker.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

protocol FileWriterWorkerProtocol {
    func write(data: Data) throws
    func retrieve() throws -> Data
}
