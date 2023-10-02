//
//  FileManager.swift
//  BelenetsAppOne
//
//  Created by Alena Belenets on 04.10.2023.
//

import Foundation

extension FileManager {
    static func getDocumentsDirectory() -> URL {
        let documentsDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectoryPath
    }

    static func getPathOfDirectory(named name: String) -> URL? {
        let documentsDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let path = documentsDirectoryPath.appendingPathComponent(name)

        do {
            try self.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
            return path
        } catch {
            assert(true, "Error creating directory")
            return nil
        }
    }
}
