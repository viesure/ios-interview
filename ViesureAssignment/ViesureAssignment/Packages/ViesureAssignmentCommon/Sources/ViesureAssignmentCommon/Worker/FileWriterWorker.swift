//
//  FileWriter.swift
//  ViesureAssignment
//
//  Created by Kurt Jacobs on 04.04.21.
//

import Foundation

public class FileWriterWorker: FileWriterWorkerProtocol {
    
    public init() { }
    
    public func write(data: Data) throws {
        try data.write(to: getDocumentsDirectory().appendingPathComponent("articles.bin"))
    }
    
    public func retrieve() throws -> Data {
        return try Data(contentsOf: getDocumentsDirectory().appendingPathComponent("articles.bin"))
    }
    
    public func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
