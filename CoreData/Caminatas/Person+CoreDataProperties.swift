//
//  Person+CoreDataProperties.swift
//  Caminatas
//
//  Created by Manuel Enrique Amores Gonzalez on 10/1/26.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var misCaminatas: NSOrderedSet?

}

// MARK: Generated accessors for misCaminatas
extension Person {

    @objc(insertObject:inMisCaminatasAtIndex:)
    @NSManaged public func insertIntoMisCaminatas(_ value: Caminata, at idx: Int)

    @objc(removeObjectFromMisCaminatasAtIndex:)
    @NSManaged public func removeFromMisCaminatas(at idx: Int)

    @objc(insertMisCaminatas:atIndexes:)
    @NSManaged public func insertIntoMisCaminatas(_ values: [Caminata], at indexes: NSIndexSet)

    @objc(removeMisCaminatasAtIndexes:)
    @NSManaged public func removeFromMisCaminatas(at indexes: NSIndexSet)

    @objc(replaceObjectInMisCaminatasAtIndex:withObject:)
    @NSManaged public func replaceMisCaminatas(at idx: Int, with value: Caminata)

    @objc(replaceMisCaminatasAtIndexes:withMisCaminatas:)
    @NSManaged public func replaceMisCaminatas(at indexes: NSIndexSet, with values: [Caminata])

    @objc(addMisCaminatasObject:)
    @NSManaged public func addToMisCaminatas(_ value: Caminata)

    @objc(removeMisCaminatasObject:)
    @NSManaged public func removeFromMisCaminatas(_ value: Caminata)

    @objc(addMisCaminatas:)
    @NSManaged public func addToMisCaminatas(_ values: NSOrderedSet)

    @objc(removeMisCaminatas:)
    @NSManaged public func removeFromMisCaminatas(_ values: NSOrderedSet)

}

extension Person : Identifiable {

}
