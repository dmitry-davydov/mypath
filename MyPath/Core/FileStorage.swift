//
//  FileStorage.swift
//  MyPath
//
//  Created by Дима Давыдов on 23.09.2021.
//

import UIKit

protocol FileStorageProtocol {
    func readUserAvatar() -> UIImage?
    func saveUserAvatar(_ image: UIImage) -> Result<Void, FileStorage.Error>
}

class FileStorage: FileStorageProtocol {
    
    enum Error: Swift.Error {
        case canNotConvertImageToJpg
        case writeError(error: Swift.Error)
    }
    
    private enum FileName: String {
        case userAvatar = "user-avatar.jpg"
    }
    
    static let shared = FileStorage()
    private init() {}
    
    private func documentsFolderURL() -> URL {
        return try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
    
    private func fileURL(for name: FileName) -> URL {
        return documentsFolderURL().appendingPathComponent(name.rawValue)
    }
    
    func readUserAvatar() -> UIImage? {
        guard FileManager.default.fileExists(atPath: fileURL(for: .userAvatar).path) else { return nil }
        guard let image = UIImage(contentsOfFile: fileURL(for: .userAvatar).path) else { return nil }
        
        return image
    }
    
    func saveUserAvatar(_ image: UIImage) -> Result<Void, Error> {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return .failure(.canNotConvertImageToJpg) }
        let filePath = fileURL(for: .userAvatar).path
        do {
            if FileManager.default.fileExists(atPath: filePath) {
                try FileManager.default.removeItem(atPath: filePath)
            }
            
            FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
            
            return .success(())
        } catch let error {
            return .failure(.writeError(error: error))
        }
    }
}
