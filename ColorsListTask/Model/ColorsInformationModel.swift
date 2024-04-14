//
//  ColorsInformation.swift
//  ColorsListTask
//
//  Created by User on 4/2/24.
//

import UIKit

struct ColorInformationModel: Codable {
    var description: String
    private var colorData: Data?
    
    var color: UIColor? {
        get {
            guard let data = colorData else { return nil }
            return try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
        }
        set {
            guard let color = newValue else { return }
            colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
        }
    }
    
    init(description: String, color: UIColor) {
        self.description = description
        self.color = color
    }
}



