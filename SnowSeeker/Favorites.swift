//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Sergey Shcheglov on 17.03.2022.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private var saveKey = "Favorites"
    
    init() {
        //load our saved data
        resorts = []
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
        resorts.insert(resort.id)
        save()
    }
    
    func save() {
        
    }
}
