//
//  Word.swift
//  simpleDictionary
//
//  Created by Tommaso Negri on 23/04/2020.
//  Copyright © 2020 Tommaso Negri. All rights reserved.
//

import Foundation

struct Words: Codable {
    var entries: [Word]
}

struct Word: Codable {
    var entry: String
    var lexemes: [Lemma]
}

struct Lemma: Codable {
    var lemma: String
    var partOfSpeech: String
    var senses: [Sense]
}

struct Sense: Codable {
    var definition: String
//    var labels: [String]
}
