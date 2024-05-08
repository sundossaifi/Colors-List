//
//  ColorTransformer.swift
//  ColorsListTask
//
//  Created by User on 4/21/24.
//

import Foundation
import UIKit
import CoreData

@objc(ColorTransformer)
final class ColorTransformer: NSSecureUnarchiveFromDataTransformer {
    
    override static var allowedTopLevelClasses: [AnyClass] {
        return [UIColor.self]
    }
    
    public static func register() {
        let transformer = ColorTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: NSValueTransformerName(rawValue: String(describing: ColorTransformer.self)))
    }
}
