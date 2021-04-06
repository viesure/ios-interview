//
//  CryptographyProvider.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation
import CommonCrypto

public class EncryptionWorker: EncryptionWorkerProtocol {
    private var key = "t6w9z$C&F)J@McQf"
    
    public init() {}
    
    public func encrypt(data: Data, fixedIvBytes: [UInt8]? = nil) -> Data {
        return cryptCC(data: data, key: key, operation: kCCEncrypt, fixedIvBytes: fixedIvBytes)
    }

    public func decrypt(data: Data) -> Data {
        return cryptCC(data: data, key: key, operation: kCCDecrypt)
    }

    private func cryptCC(data: Data, key: String, operation: Int, fixedIvBytes: [UInt8]? = nil) -> Data {
        guard key.count == kCCKeySizeAES128 else {
            fatalError("Key Size Mismatch")
        }

        var ivBytes: [UInt8]
        var inBytes: [UInt8]
        var outLength: Int

        if operation == kCCEncrypt {
            ivBytes = [UInt8](repeating: 0, count: kCCBlockSizeAES128)
            if fixedIvBytes == nil {
                guard kCCSuccess == SecRandomCopyBytes(kSecRandomDefault, ivBytes.count, &ivBytes) else {
                    fatalError("IV Creation Failure")
                }
            } else {
                ivBytes = fixedIvBytes!
            }

            inBytes = Array(data)
            outLength = data.count + kCCBlockSizeAES128

        } else {
            ivBytes = Array(Array(data).dropLast(data.count - kCCBlockSizeAES128))
            inBytes = Array(Array(data).dropFirst(kCCBlockSizeAES128))
            outLength = inBytes.count

        }

        var outBytes = [UInt8](repeating: 0, count: outLength)
        var bytesMutated = 0

        guard kCCSuccess == CCCrypt(CCOperation(operation), CCAlgorithm(kCCAlgorithmAES128), CCOptions(kCCOptionPKCS7Padding), Array(key), kCCKeySizeAES128, &ivBytes, &inBytes, inBytes.count, &outBytes, outLength, &bytesMutated) else {
            fatalError("Cryptography operation \(operation) failed")
        }

        var output = Data(bytes: &outBytes, count: bytesMutated)

        if operation == kCCEncrypt {
            ivBytes.append(contentsOf: Array(output))
            output = Data(ivBytes)
        }
        return output
    }
}

