//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Sergey Shcheglov on 17.03.2022.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
//    private var saveKey: String = "Favorites"
    private var savePath = FileManager.documentDirectory.appendingPathComponent("Favorites")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
            print("okey")
        } catch {
            resorts = []
            print("empty")
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            print("Saved")
        } catch {
            print("unable to save data: \(error.localizedDescription)")
        }
    }
}
