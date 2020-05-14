//
//  ApiCache+PersistProvider.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

protocol ApiCachePersistProviderProtocol {

    var providerName: String { get }
    var maxAge: Double { get }

    func insertValue(_ value: Cache, forKey key: URL)
    func getValueForKey(_ key: URL) -> Cache?
    func cache() -> Dictionary<URL, Cache>?
}

class UserDefaultsPersistProvider: ApiCachePersistProviderProtocol {

    let providerName: String
    let maxAge: Double
    let userDefaults: UserDefaults

    init(providerName: String, maxAge: Double, userDefaults: UserDefaults = UserDefaults.standard) {
        self.providerName = providerName
        self.maxAge = maxAge
        self.userDefaults = userDefaults
    }

    func insertValue(_ value: Cache, forKey key: URL) {
        guard var storage = persistedStorage() else {

            let dict: Dictionary<URL, Cache> = [key: value]
            persistStorage(storage: dict)

            return
        }

        storage[key] = value

        persistStorage(storage: storage)
    }

    func getValueForKey(_ key: URL) -> Cache? {
        guard let storage = persistedStorage() else {
            return nil
        }

        return storage[key]
    }

    func cache() -> Dictionary<URL, Cache>? {
        guard let storage = persistedStorage() else {
            return nil
        }

        return removeValuesIfTooOld(storage: storage)
    }

    // MARK: - Private

    private func removeValuesIfTooOld(storage: Dictionary<URL, Cache>) -> Dictionary<URL, Cache> {
        var storage = storage
        storage.forEach { (key, value) in
            if value.age.addingTimeInterval(maxAge) < Date() {
                storage.removeValue(forKey: key)
            }
        }

        persistStorage(storage: storage)

        return storage
    }

    private func persistedStorage() -> Dictionary<URL, Cache>? {
        guard let data = userDefaults.value(forKey: providerName) as? Data,
            let storageDict = try? JSONDecoder().decode(Dictionary<URL, Cache>.self, from: data) else {
                return nil
        }

        return storageDict
    }

    private func persistStorage(storage: Dictionary<URL, Cache>) {
        let updatedData = try? JSONEncoder().encode(storage)
        userDefaults.setValue(updatedData, forKey: providerName)
        userDefaults.synchronize()
    }

}
