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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - recentSearchedTableView
    
    // Define rows for recentSearchedTableView based on array TEMP
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searched.count
    }
    
    // Define cells for recentSearchedTableView based on array TEMP
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recentSearched", for: indexPath)
        
        cell.textLabel!.text = searched[indexPath.item]
        
        return cell
    }
    
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
