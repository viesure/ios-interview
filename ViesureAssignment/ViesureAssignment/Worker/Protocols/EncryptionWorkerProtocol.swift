//
//  EncryptionWorkerProtocol.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

protocol EncryptionWorkerProtocol {
    func encrypt(data: Data, fixedIvBytes: [UInt8]?) -> Data
    func decrypt(data: Data) -> Data
}
