//
//  FileWriterWorkerMock.swift
//  ViesureAssignmentTests
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import ViesureAssignmentCommon

class FileWriterWorkerMock: FileWriterWorkerProtocol {
    var data: Data = Data()
    
    func write(data: Data) throws {
        self.data = data
    }
    
    func retrieve() throws -> Data {
        return self.data
    }
}
