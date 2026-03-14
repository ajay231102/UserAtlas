//
//  UserCacheManager.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 14/03/26.
//

import Foundation

final class UserCacheManager {
    
    static let shared = UserCacheManager()
    private init() {
        createCacheDirectoryIfNeeded()
    }
    
    private let memoryCache = NSCache<NSString, NSData>()
    private let fileManager = FileManager.default
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private lazy var cacheDirectoryURL: URL = {
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[0].appendingPathComponent("CommonCache", isDirectory: true)
    }()
    
    private func createCacheDirectoryIfNeeded() {
        if !fileManager.fileExists(atPath: cacheDirectoryURL.path) {
            try? fileManager.createDirectory(at: cacheDirectoryURL,
                                             withIntermediateDirectories: true,
                                             attributes: nil)
        }
    }
    
    private func fileURL(for key: String) -> URL {
        let safeKey = key.replacingOccurrences(of: "/", with: "_")
                         .replacingOccurrences(of: ":", with: "_")
                         .replacingOccurrences(of: "?", with: "_")
                         .replacingOccurrences(of: "&", with: "_")
        return cacheDirectoryURL.appendingPathComponent("\(safeKey).json")
    }
    
    func save<T: Codable>(_ object: T, forKey key: String) {
        do {
            let data = try encoder.encode(object)
            
            memoryCache.setObject(data as NSData, forKey: key as NSString)
            
            let url = fileURL(for: key)
            try data.write(to: url, options: .atomic)
        } catch {
            print("Cache save failed: \(error.localizedDescription)")
        }
    }
    
    func getObject<T: Codable>(forKey key: String, type: T.Type) -> T? {
        
        if let cachedData = memoryCache.object(forKey: key as NSString) as Data? {
            do {
                let object = try decoder.decode(T.self, from: cachedData)
                return object
            } catch {
                print("Memory cache decode failed: \(error.localizedDescription)")
            }
        }
        
        let url = fileURL(for: key)
        guard fileManager.fileExists(atPath: url.path) else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            memoryCache.setObject(data as NSData, forKey: key as NSString)
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            print("Disk cache read failed: \(error.localizedDescription)")
            return nil
        }
    }
    
    func removeObject(forKey key: String) {
        memoryCache.removeObject(forKey: key as NSString)
        
        let url = fileURL(for: key)
        try? fileManager.removeItem(at: url)
    }
    
    func clearAllCache() {
        memoryCache.removeAllObjects()
        
        do {
            let files = try fileManager.contentsOfDirectory(at: cacheDirectoryURL,
                                                            includingPropertiesForKeys: nil)
            for file in files {
                try? fileManager.removeItem(at: file)
            }
        } catch {
            print("Clear cache failed: \(error.localizedDescription)")
        }
    }
}
