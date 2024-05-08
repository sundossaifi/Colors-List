//
//  ColorsListVC.swift
//  ColorsListTask
//
//  Created by User on 4/2/24.
//

import UIKit

class ColorsListVC: UIViewController, NewColorDelegate, ColorsListCellDelegate {
    @IBOutlet var colorsTableView: UITableView!
    @IBOutlet var colorDescriptionLabel: UILabel!
    @IBOutlet var colorDescriptionView: UIView!
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var deleteSelectedColorsButton: UIButton!
    @IBOutlet weak var addColorButton: UIButton!
    
    var viewModel = ColorsListViewModel()
    var selectedColorIndices: [IndexPath] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        colorsTableView.register(ColorsListCell.nib(), forCellReuseIdentifier: ColorsListCell.identifier)
        viewModel.fetchColorsList()
        colorsTableView.reloadData()
    }
    
    @IBAction func editColorsOrder(_ sender: Any) {
        let title = viewModel.toggleEditing()
        tabBarView.isHidden.toggle()
        editButton.title = title
        colorsTableView.setEditing(!colorsTableView.isEditing, animated: true)
        colorsTableView.reloadData()
        selectedColorIndices.removeAll()
        colorsTableView.reloadData()
    }
    
    @IBAction func deleteSelectedColors(_ sender: Any) {
        viewModel.deleteColors(at: selectedColorIndices) { [weak self] deletedIndexPaths in
            guard let self = self else { return }
            self.colorsTableView.performBatchUpdates {
                self.colorsTableView.deleteRows(at: deletedIndexPaths, with: .right)
            } completion: { _ in
                self.selectedColorIndices.removeAll()
                self.colorsTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newColorVC = segue.destination as? NewColorVC {
            newColorVC.delegate = self
        }
    }
    
    func didAddNewColor() {
        viewModel.fetchColorsList()
        colorsTableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    func didToggleSelection(state: Bool, at indexPath: IndexPath) {
        if state {
            selectedColorIndices.append(indexPath)
        } else {
            if let index = selectedColorIndices.firstIndex(of: indexPath) {
                selectedColorIndices.remove(at: index)
            }
        }
    }
}

extension ColorsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellsCount(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = colorsTableView.dequeueReusableCell(withIdentifier: ColorsListCell.identifier, for: indexPath) as? ColorsListCell else {
            fatalError("The dequeued cell is not an instance of ColorsListCell.")
        }
        let colorModel = viewModel.colorsList[indexPath.row]
        cell.configureCell(with: colorModel)
        cell.colorNameLabel.textColor = .systemBackground
        cell.selectButton.isHidden = !viewModel.isSelectButtonVisible
        cell.delegate = self
        cell.indexPath = indexPath
        cell.selectButton.isSelected = selectedColorIndices.contains(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        colorDescriptionView.backgroundColor = viewModel.colorsList[indexPath.row].colorEntity.color
        colorDescriptionLabel.text = viewModel.colorsList[indexPath.row].colorEntity.colorDescription
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
