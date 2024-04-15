//
//  TableViewCellNib.swift
//  ColorsListTask
//
//  Created by User on 4/15/24.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
