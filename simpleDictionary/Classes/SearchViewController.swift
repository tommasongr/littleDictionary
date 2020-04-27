//
//  SearchViewController.swift
//  simpleDictionary
//
//  Created by Tommaso Negri on 22/04/2020.
//  Copyright © 2020 Tommaso Negri. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var recentSearchedTableView: UITableView!
    
    var searched: [String] = ["Hello", "Hola", "Good Morning", "Ciao"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        let tableHeaderLabel = UILabel()
        tableHeaderLabel.text = "Recent"
        
        let tableHeaderButton = UIButton(type: UIButton.ButtonType.system)
        tableHeaderButton.setTitle("Clear", for: UIControl.State.normal)
        
        let tableHeader = UIStackView(arrangedSubviews: [tableHeaderLabel, tableHeaderButton])
        tableHeader.axis = .horizontal
        tableHeader.distribution = .fillProportionally
        tableHeader.alignment = .fill
//        tableHeader.spacing = 5
        tableHeader.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableHeader)
        tableHeader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableHeader.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        tableHeader.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        recentSearchedTableView.tableHeaderView = tableHeader
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - recentSearchedTableView

extension SearchViewController: UITableViewDelegate {
    // When the row is selected perform the segue to the details view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "searchedDetails", sender: nil)
    }
    
    // Deselect row after segue with animation
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = recentSearchedTableView.indexPathForSelectedRow {
            recentSearchedTableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    // Define rows for recentSearchedTableView based on array TEMP
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searched.count
    }
    
    // Define cells for recentSearchedTableView based on array TEMP
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentSearched", for: indexPath)
        
        cell.textLabel!.text = searched[indexPath.row]
        
        return cell
    }
}
