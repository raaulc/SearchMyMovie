//
//  View+DataCache.swift

import Foundation
import SwiftUI

// Application cache designed for caching network data requests.
private let kAppDataCache = NSCache<NSString, NSData>()

extension View {
    // Attempt to retrieve an item from application cache.
    
    // The cache is an application level object, shared by all `View`s. If one view
    // caches the data for an image by the URL, that image data will be available
    // to another view downstream.
    
    // - Parameter key: 'String' key associated with the cached 'Data'.
    // - Returns: Returns 'Data' if the key is found; otherwise 'nil'.
    
    func cached(key: String) -> Data? {
        kAppDataCache.object(forKey: NSString(string: key)) as Data?
    }
    
    // Add an object to the application cache.
    
    // | Parameters:
    //   - key: 'String' key to associate with the 'Data'.
    //   - value: 'Data' to associate with the key.
    func cache(key: String, value: Data) {
        kAppDataCache.setObject(NSData(data: value), forKey: NSString(string: key))
    }
}
