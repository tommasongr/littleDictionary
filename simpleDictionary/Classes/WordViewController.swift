//
//  WordViewController.swift
//  simpleDictionary
//
//  Created by Tommaso Negri on 23/04/2020.
//  Copyright © 2020 Tommaso Negri. All rights reserved.
//

import UIKit

class WordViewController: UIViewController {
    
    var word: Word?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = word?.entry.capitalized
    }

}
