//
//  ColorEntity+CoreDataProperties.swift
//  ColorsListTask
//
//  Created by User on 4/17/24.
//
//

import CoreData
import UIKit


extension ColorEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ColorEntity> {
        return NSFetchRequest<ColorEntity>(entityName: "ColorEntity")
    }

    @NSManaged public var color: UIColor?
    @NSManaged public var colorDescription: String?
    @NSManaged public var colorTitle: String?
    @NSManaged public var displayOrder: Int64

}

extension ColorEntity : Identifiable {

}
