//
//  ColorsListCell.swift
//  ColorsListTask
//
//  Created by User on 4/15/24.
//

import UIKit

class ColorsListCell: UITableViewCell {
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var colorNameLabel: UILabel!
    
    @IBAction func selectButtonTapped(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        button.isSelected.toggle()
        button.backgroundColor = .clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSelectButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureSelectButton() {
        selectButton.layer.cornerRadius = selectButton.frame.height / 2
        let selectedImage = UIImage(systemName: "checkmark.circle.fill")
        let unselectedImage = UIImage(systemName: "circle")
        selectButton.setImage(unselectedImage, for: .normal)
        selectButton.setImage(selectedImage, for: .selected)
        selectButton.backgroundColor = .clear
    }
}
