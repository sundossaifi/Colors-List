//
//  ColorsViewModel.swift
//  ColorsListTask
//
//  Created by User on 4/14/24.
//

import UIKit

class ColorsListViewModel {
    var colorsList: [ColorCellModel] = []
    private var isEditing: Bool = false
    var isSelectButtonVisible: Bool = false

    func getCellsCount(in section: Int) -> Int {
        return colorsList.count
    }
    
    func fetchColorsList() {
        let fetchedColors = CoreDataManager.shared.fetchColors()
        colorsList = fetchedColors.map {
            ColorCellModel(colorEntity: $0, isSelected: false)
        }
    }
    
    func moveColor(from sourceIndex: Int, to destinationIndex: Int) {
        let color = colorsList.remove(at: sourceIndex)
        colorsList.insert(color, at: destinationIndex)
        for (index, colorModel) in colorsList.enumerated() {
            colorModel.colorEntity.displayOrder = Int64(index)
        }
        CoreDataManager.shared.saveContext()
    }

    func toggleEditing() -> String {
        isEditing.toggle()
        isSelectButtonVisible = isEditing
        return isEditing ? "Done" : "Edit"
    }
    
    func deleteColors(at indexPaths: [IndexPath], completion: @escaping ([IndexPath]) -> Void) {
        let sortedIndices = indexPaths.sorted(by: { $0.row > $1.row })
        for indexPath in sortedIndices {
            let colorModel = colorsList[indexPath.row]
            CoreDataManager.shared.deleteColor(colorModel.colorEntity)
        }
        CoreDataManager.shared.saveContext()
        fetchColorsList()
        completion(sortedIndices)
    }
}
