//
//  FileWriter.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

class FileWriterWorker: FileWriterWorkerProtocol {
    func write(data: Data) throws {
        try data.write(to: getDocumentsDirectory().appendingPathComponent("articles.bin"))
    }
    
    func retrieve() throws -> Data {
        return try Data(contentsOf: getDocumentsDirectory().appendingPathComponent("articles.bin"))
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
