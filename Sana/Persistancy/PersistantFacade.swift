//
//  PersistantFacade.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 20.06.2022.
//

import CoreData

protocol PersistantFacade {
    var container: NSPersistentContainer { get }
}

class PersistantFacadeImpl: PersistantFacade, ObservableObject {
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                dump(error)
            }
        }
    }
}
