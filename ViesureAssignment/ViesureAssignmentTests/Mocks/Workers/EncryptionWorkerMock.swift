//
//  EncryptionWorkerMock.swift
//  ViesureAssignmentTests
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
@testable import ViesureAssignment

class EncryptionWorkerMock: EncryptionWorkerProtocol {
    var data: Data = Data()
    
    func encrypt(data: Data, fixedIvBytes: [UInt8]?) -> Data {
        self.data = data
        return data
    }

    func decrypt(data: Data) -> Data {
        return data
    }
}
