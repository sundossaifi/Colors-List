//
//  ColorsListVC.swift
//  ColorsListTask
//
//  Created by User on 4/2/24.
//

import UIKit

class ColorsListVC: UIViewController {
    
    @IBOutlet var colorsTableView: UITableView!
    @IBOutlet var colorDescriptionLabel: UILabel!
    @IBOutlet var colorDescriptionView: UIView!
    @IBOutlet var editButton: UIBarButtonItem!
    
    var viewModel = ColorsViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        colorsTableView.register(ColorsListCell.nib(), forCellReuseIdentifier: ColorsListCell.identifier)
    }
    
    @IBAction func editColorsOrder(_ sender: Any) {
        let title = viewModel.toggleEditing()
        editButton.title = title
        colorsTableView.setEditing(!colorsTableView.isEditing, animated: true)
        colorsTableView.reloadData()
    }
}

extension ColorsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellsCount(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = colorsTableView.dequeueReusableCell(withIdentifier: ColorsListCell.identifier, for: indexPath) as! ColorsListCell
        cell.backgroundColor = viewModel.color(at: indexPath.row)
        cell.colorNameLabel.text = viewModel.color(at: indexPath.row)?.accessibilityName
        cell.colorNameLabel.textColor = .systemBackground
        cell.selectButton.isHidden = !viewModel.isSelectButtonVisible
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        colorDescriptionView.backgroundColor = viewModel.color(at: indexPath.row)
        colorDescriptionLabel.text = viewModel.colorDescription(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.moveColor(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
