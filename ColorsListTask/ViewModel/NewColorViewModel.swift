//
//  NewColorViewModel.swift
//  ColorsListTask
//
//  Created by User on 4/17/24.
//

import UIKit

class NewColorViewModel {
    func addColor(colorTitle: String, colorDescription: String, color: UIColor) {
        CoreDataManager.shared.addColor(title: colorTitle, description: colorDescription, color: color)
    }
}
