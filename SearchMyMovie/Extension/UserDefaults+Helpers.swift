//
//  UserDefaults+Helpers.swift

import Foundation

extension UserDefaults {
    // Max. number of elements to keep in the recent search list.
    static let maxRecentItems = 5
    
    // Well known keys for reading and writing values from 'UserDefaults'.
    enum AppKeys: String {
        case recents
    }
    
    // Returns the shared defaults object.
    static var shared: UserDefaults {
        UserDefaults.standard
    }
    
    // Returns array of recent searches. Default is an empty array.
    var recents: [String] {
        guard let recents = UserDefaults.shared.object(forKey: AppKeys.recents.rawValue) as? [String]
        else { return [] }
        return recents
    }
    
    // Add a recent search to store.
    // Maintains a rolling list of search requests, with a maximum of 5 searches.
    // - Parameter value: value to store.
    func addRecent(value: String) {
        var values = recents
        values.insert(value, at: 0)
        if values.count > Self.maxRecentItems {
            values.removeLast()
        }
        UserDefaults.shared.setValue(values, forKey: AppKeys.recents.rawValue)
    }
    
    // Removes a set of indexes from the resent search list.
    // - Parameter offsets: 'IndexSet' of indexes to remove.
    func removeRecents(in offsets: IndexSet) {
        var values = recents
        values.remove(atOffsets: offsets)
        UserDefaults.shared.setValue(values, forKey: AppKeys.recents.rawValue)
    }
}
