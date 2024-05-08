//
//  CoreDataManeger.swift
//  ColorsListTask
//
//  Created by User on 4/16/24.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private let context: NSManagedObjectContext

    private init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            context = appDelegate.persistentContainer.viewContext
        } else {
            fatalError("Unable to access AppDelegate")
        }
    }

    func fetchColors() -> [ColorEntity] {
        let fetchRequest: NSFetchRequest<ColorEntity> = ColorEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "displayOrder", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("\(error)")
            return []
        }
    }

    func addColor(title: String, description: String, color: UIColor) {
        let newColor = ColorEntity(context: context)
        newColor.colorTitle = title
        newColor.colorDescription = description
        newColor.color = color
        saveContext()
    }
    
    func deleteColor(_ colorEntity: ColorEntity) {
        context.delete(colorEntity)
        saveContext()
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("\(error)")
            }
        }
    }
}
