//
//  NewColorVC.swift
//  ColorsListTask
//
//  Created by User on 4/16/24.
//

import UIKit

protocol NewColorDelegate: AnyObject {
    func didAddNewColor()
}

class NewColorVC: UIViewController {
    
    @IBOutlet weak var colorTitleTextField: UITextField!
    @IBOutlet weak var colorWell: UIColorWell!
    @IBOutlet weak var colorDescriptionTextView: UITextView!
    @IBOutlet weak var addColorButton: UIButton!
    
    weak var delegate: NewColorDelegate?
    
    var viewModel = NewColorViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFields()
    }
    
    func configureFields() {
        colorTitleTextField.layer.cornerRadius = colorTitleTextField.frame.height/2
        colorTitleTextField.layer.borderColor = UIColor.lightGray.cgColor
        colorTitleTextField.layer.borderWidth = 1.0
        colorTitleTextField.layer.masksToBounds = true
        
        colorDescriptionTextView.layer.cornerRadius = colorDescriptionTextView.frame.height/8
        colorDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        colorDescriptionTextView.layer.borderWidth = 1.0
        colorDescriptionTextView.layer.masksToBounds = true
        
        addColorButton.layer.cornerRadius = addColorButton.frame.height/2
        addColorButton.layer.masksToBounds = true
    }
    
    @IBAction func addColor(_ sender: Any) {
        if let title = colorTitleTextField.text,
           let description = colorDescriptionTextView.text,
           let color = colorWell.selectedColor {
            viewModel.addColor(colorTitle: title, colorDescription: description, color: color)
        } else {
            
        }
        delegate?.didAddNewColor()
        colorTitleTextField.text = ""
        colorDescriptionTextView.text = ""
    }
}
