//
//  LocalTaskEntity+CoreDataProperties.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/28/24.
//
//

import Foundation
import CoreData


extension LocalTaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalTaskEntity> {
        return NSFetchRequest<LocalTaskEntity>(entityName: "LocalTaskEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var descripsion: String?
    @NSManaged public var id: UUID?
    @NSManaged public var iscompleted: Bool
    @NSManaged public var title: String?

}

extension LocalTaskEntity : Identifiable {

}
