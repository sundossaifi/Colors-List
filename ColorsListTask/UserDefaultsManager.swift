//
//  UserDefaultsManager.swift
//  ColorsListTask
//
//  Created by User on 4/6/24.
//

import UIKit

struct UserDefaultsManager {
    
    static func saveColors(colorsList: [ColorInformationModel]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(colorsList)
            UserDefaults.standard.set(data, forKey: "colorsList")
        } catch {
            print("Failed to encode colors: \(error)")
        }
    }
    
    static func loadColors() -> [ColorInformationModel]? {
        guard let data = UserDefaults.standard.data(forKey: "colorsList") else { return nil }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode([ColorInformationModel].self, from: data)
        } catch {
            print("Failed to decode colors: \(error)")
            return nil
        }
    }
    
    static func addDefaultColors() -> [ColorInformationModel] {
        return [
            ColorInformationModel(description: "Red Description", color: .systemRed),
            ColorInformationModel(description: "Red Description", color: .systemRed),
            ColorInformationModel(description: "Blue Description", color: .systemBlue),
            ColorInformationModel(description: "Green Description", color: .systemGreen),
            ColorInformationModel(description: "Gray Description", color: .systemGray),
            ColorInformationModel(description: "Red Description", color: .systemRed),
            ColorInformationModel(description: "Blue Description", color: .systemBlue),
            ColorInformationModel(description: "Green Description", color: .systemGreen),
            ColorInformationModel(description: "Gray Description", color: .systemGray),
            ColorInformationModel(description: "Red Description", color: .systemRed),
            ColorInformationModel(description: "Blue Description", color: .systemBlue),
            ColorInformationModel(description: "Green Description", color: .systemGreen),
            ColorInformationModel(description: "Gray Description", color: .systemGray)
        ]
    }
}
