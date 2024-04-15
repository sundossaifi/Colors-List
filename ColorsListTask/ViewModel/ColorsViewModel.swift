//
//  ColorsViewModel.swift
//  ColorsListTask
//
//  Created by User on 4/14/24.
//

import UIKit

class ColorsViewModel {
    private var colorsList: [ColorInformationModel] = []
    private var isEditing: Bool = false
    var isSelectButtonVisible: Bool = false
    
    init() {
          loadColors()
      }
    
    func getCellsCount(in section: Int) -> Int {
        return colorsList.count
    }
    
    func color(at index: Int) -> UIColor? {
        return colorsList[index].color
    }
    
    func colorDescription(at index: Int) -> String {
        return colorsList[index].description
    }
    
    func loadColors() {
        colorsList = UserDefaultsManager.loadColors() ?? []
        if colorsList.isEmpty {
            colorsList = UserDefaultsManager.addDefaultColors()
            UserDefaultsManager.saveColors(colorsList: colorsList)
        }
    }
    
    func toggleEditing() -> String {
        isEditing.toggle()
        isSelectButtonVisible = isEditing
        if isEditing {
            return "Done"
        } else {
            UserDefaultsManager.saveColors(colorsList: colorsList)
            return "Edit"
        }
    }
    
    func moveColor(from sourceIndex: Int, to destinationIndex: Int) {
        let color = colorsList.remove(at: sourceIndex)
        colorsList.insert(color, at: destinationIndex)
        UserDefaultsManager.saveColors(colorsList: colorsList)
    }
}
