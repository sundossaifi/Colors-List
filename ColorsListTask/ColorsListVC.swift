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
    
    var colorsList: [ColorInformationModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        colorsList = UserDefaultsManager.loadColors() ?? []
        if colorsList.isEmpty {
            colorsList = UserDefaultsManager.addDefaultColors()
            UserDefaultsManager.saveColors(colorsList: colorsList)
        }
    }
    
    @IBAction func editColorsOrder(_ sender: Any) {
        colorsTableView.isEditing.toggle() 
        if colorsTableView.isEditing {
            editButton.title = "Done"

        } else {
            editButton.title = "Edit"
        }
    }
}

extension ColorsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = colorsTableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath)
        let colorInfo = colorsList[indexPath.row]
        cell.backgroundColor = colorInfo.color
        cell.textLabel?.text = colorInfo.color?.accessibilityName
        cell.textLabel?.textColor = .systemBackground
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let colorInfo = colorsList[indexPath.row]
        colorDescriptionView.backgroundColor = colorInfo.color
        colorDescriptionLabel.text = colorInfo.description
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = colorsList[sourceIndexPath.row]
        colorsList.remove(at: sourceIndexPath.row)
        colorsList.insert(item, at: destinationIndexPath.row)
        UserDefaultsManager.saveColors(colorsList: colorsList)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
