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
    
    let colorsList:[ColorInformation] = [
        ColorInformation(colorName: "Red", colorDescription: "Red Description", color: .systemRed),
        ColorInformation(colorName: "Blue", colorDescription: "Blue Description", color: .systemBlue),
        ColorInformation(colorName: "Green", colorDescription: "Green Description", color: .systemGreen),
        ColorInformation(colorName: "Gray", colorDescription: "Gray Description", color: .systemGray),
        ColorInformation(colorName: "Red", colorDescription: "Red Description", color: .systemRed),
        ColorInformation(colorName: "Blue", colorDescription: "Blue Description", color: .systemBlue),
        ColorInformation(colorName: "Green", colorDescription: "Green Description", color: .systemGreen),
        ColorInformation(colorName: "Gray", colorDescription: "Gray Description", color: .systemGray),
        ColorInformation(colorName: "Red", colorDescription: "Red Description", color: .systemRed),
        ColorInformation(colorName: "Blue", colorDescription: "Blue Description", color: .systemBlue),
        ColorInformation(colorName: "Green", colorDescription: "Green Description", color: .systemGreen),
        ColorInformation(colorName: "Gray", colorDescription: "Gray Description", color: .systemGray),
        ColorInformation(colorName: "Red", colorDescription: "Red Description", color: .systemRed),
        ColorInformation(colorName: "Blue", colorDescription: "Blue Description", color: .systemBlue),
        ColorInformation(colorName: "Green", colorDescription: "Green Description", color: .systemGreen),
        ColorInformation(colorName: "Gray", colorDescription: "Gray Description", color: .systemGray)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.textLabel?.text = colorInfo.colorName
        cell.textLabel?.textColor = .systemBackground
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let colorInfo = colorsList[indexPath.row]
        colorDescriptionView.backgroundColor = colorInfo.color
        colorDescriptionLabel.text = colorInfo.colorDescription
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
