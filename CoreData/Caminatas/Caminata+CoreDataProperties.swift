//
//  Caminata+CoreDataProperties.swift
//  Caminatas
//
//  Created by Manuel Enrique Amores Gonzalez on 10/1/26.
//
//

import Foundation
import CoreData


extension Caminata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Caminata> {
        return NSFetchRequest<Caminata>(entityName: "Caminata")
    }

    @NSManaged public var date: Date?
    @NSManaged public var caminata: Person?

}

extension Caminata : Identifiable {

}
