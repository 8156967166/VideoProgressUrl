//
//  SJDataCatch.swift
//  LIST&SEEK
//
//  Created by Arun SJ on 20/07/18.
//  Copyright © 2018 Arun SJ. All rights reserved.
//

import Foundation


open class SJDataCache{
    //    private static var sharedDataCache:SJDataCache = {
    //        let dataCache = SJDataCache();
    //        return dataCache;
    //    }();
    
    fileprivate init() { }
    
    //    class func shared()->SJDataCache{
    //        return sharedDataCache;
    //    }
    
    public enum Directory {
        case documents
        case caches
    }
    
    /// Returns URL constructed from specified directory
    static fileprivate func getURL(for directory: Directory) -> URL {
        var searchPathDirectory: FileManager.SearchPathDirectory
        
        switch directory {
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }
        
        if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory!")
        }
    }
    
    static public func storeAsSecure(_ data:Data, to directory: Directory, as fileName: String) {
        let url = getURL(for: directory).appendingPathComponent(self.getDataFileName(name: fileName), isDirectory: false)
        //print("Image store URL:" + url.path)
        //let encoder = JSONEncoder()
        do {
            //let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: [FileAttributeKey.protectionKey : FileProtectionType.complete])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static public func store(_ data:Data, to directory: Directory, as fileName: String) {
        let url = getURL(for: directory).appendingPathComponent(self.getDataFileName(name: fileName), isDirectory: false)
        //print("Image store URL:" + url.path)
        //let encoder = JSONEncoder()
        do {
            //let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static public func retrieve(_ fileName: String, from directory: Directory) -> Data? {
        let url = getURL(for: directory).appendingPathComponent(self.getDataFileName(name: fileName), isDirectory: false)
        //print("Image retrieve URL:" + url.path)
        if !FileManager.default.fileExists(atPath: url.path) {
            //fatalError("File at path \(url.path) does not exist!")
            return nil;
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            //let decoder = JSONDecoder()
            //do {
            //let model = try decoder.decode(type, from: data)
            return data;
            //} catch {
            //fatalError(error.localizedDescription)
            // }
        } else {
            //fatalError("No data at \(url.path)!")
            return nil;
        }
    }
    
    static public func fileExists(_ fileName: String, in directory: Directory) -> Bool {
        let url = getURL(for: directory).appendingPathComponent(self.getDataFileName(name: fileName), isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    static func getDataFileName(name:String)-> String {
        var fileName:String = "";
        fileName = name.replacingOccurrences(of: "/", with: "")
        fileName = fileName.replacingOccurrences(of: ":", with: "")
        // name = name.replacingOccurrences(of: "", with: "")
        return fileName;
    }
}




