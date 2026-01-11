//
//  CoreDataStack.swift
//  Caminatas
//
//  Created by Manuel Enrique Amores Gonzalez on 11/12/25.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "caminatas")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error al cargar Core Data: \(error), \(error.userInfo)")
            }
        }
        
        // Configuración moderna
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    // Acceso directo al contexto principal
    var context: NSManagedObjectContext {
        container.viewContext
    }

    // Guardar cambios
    func save() {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error al guardar Core Data: \(error.localizedDescription)")
            }
        }
    }
}
