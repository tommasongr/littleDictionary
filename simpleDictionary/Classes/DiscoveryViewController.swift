//
//  DiscoveryViewController.swift
//  simpleDictionary
//
//  Created by Tommaso Negri on 22/04/2020.
//  Copyright © 2020 Tommaso Negri. All rights reserved.
//

import UIKit

class DiscoveryViewController: UIViewController {

    @IBOutlet var discoveryTableView: UITableView!
    
    var words: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        
        let API_HEADER = [
            "x-rapidapi-host": "lingua-robot.p.rapidapi.com",
            "x-rapidapi-key": "67fd5cf601msh382ba30a8182f55p16125ajsnc4de5a346fb0"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://lingua-robot.p.rapidapi.com/language/v1/entries/en/example")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = API_HEADER
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
            var result: Words?
            do {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse!)
                
                result = try JSONDecoder().decode(Words.self, from: data)
            } catch {
                print("FAILED: \(error)")
            }
            
            guard let json = result else {
                return
            }
            
            self.words = json.entries
            
//            print(json)
            
            DispatchQueue.main.async {
                self.discoveryTableView.reloadData()
            }
        })

        dataTask.resume()
        
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "discoveryWord" {
            let destVC = segue.destination as! WordViewController
            destVC.word = sender as? Word
        }
    }
}

// MARK: - discoveryTableView

extension DiscoveryViewController: UITableViewDelegate {
    // When the row is selected perform the segue to the details view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let word = words[indexPath.row]
        performSegue(withIdentifier: "discoveryWord", sender: word)
    }
    
    // Deselect row after segue with animation
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = discoveryTableView.indexPathForSelectedRow {
            discoveryTableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
}

extension DiscoveryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discoveryCell", for: indexPath)
        
        cell.textLabel?.text = words[indexPath.row].entry.capitalized
        
        return cell
    }
}
