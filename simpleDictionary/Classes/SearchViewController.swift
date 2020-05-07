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
    
    var searched: [Word] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // Computed props for searching
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        searchController.searchBar.delegate = self
        
        let request = WordRequest()
        var response: Word?
        
        request.requestWords(word: "cat", completionHandler: {entries in
            
            response = entries[0]
            
            if let res = response {
                self.searched.append(res)
            }
        })
        
//        let tableHeaderLabel = UILabel()
//        tableHeaderLabel.text = "Recent"
//
//        let tableHeaderButton = UIButton(type: UIButton.ButtonType.system)
//        tableHeaderButton.setTitle("Clear", for: UIControl.State.normal)
//
//        let tableHeader = UIStackView(arrangedSubviews: [tableHeaderLabel, tableHeaderButton])
//        tableHeader.axis = .horizontal
//        tableHeader.distribution = .fillProportionally
//        tableHeader.alignment = .fill
//        tableHeader.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(tableHeader)
//        tableHeader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
//        tableHeader.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
//        tableHeader.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
//        recentSearchedTableView.tableHeaderView = tableHeader
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a word"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchedDetails" {
            let destVC = segue.destination as! WordViewController
            destVC.word = sender as? Word
        }
    }

}

// MARK: - recentSearchedTableView

extension SearchViewController: UITableViewDelegate {
    // When the row is selected perform the segue to the details view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word = searched[indexPath.row]
        performSegue(withIdentifier: "searchedDetails", sender: word)
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
        
        let word: Word
        
        word = searched[indexPath.row]
        
        cell.textLabel!.text = word.entry.capitalized
        
        return cell
    }
}

// MARK: - Search Result Updating
//extension SearchViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//
//        let searchBar = searchController.searchBar
//
//    }
//}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if isFiltering {
            let request = WordRequest()
            
            searched = []
            
            request.requestWords(word: searchBar.text!, completionHandler: {entries in
                
                for word in entries {
                    print(word.entry)
                    self.searched.append(word)
                    
                    DispatchQueue.main.async {
                        self.recentSearchedTableView.reloadData()
                    }
                }
                
            })
        }
        
    }
}
