//
//  Pokemon.swift
//  Pokedex
//
//  Created by Duc Lam on 7/19/17.
//  Copyright © 2017 Duc Lam. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _pokemonURL: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            if let dictionary = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dictionary["weight"] as? String {
                    self._weight = weight
            }
                if let height = dictionary["height"] as? String {
                    self._height = height
                }
                if let attack = dictionary["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dictionary["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let types = dictionary["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    if types.count > 1 {
                        for i in 1..<types.count {
                            if let name = types[i]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    self._type = "Unknown Type"
                }
                if let descriptionArray = dictionary["descriptions"] as? [Dictionary<String, String>] , descriptionArray.count > 0 {
                    if let url = descriptionArray[0]["resource_uri"] {
                        let completedURL = "\(URL_BASE)\(url)"
                        Alamofire.request(completedURL).responseJSON(completionHandler: { (response) in
                            if let descriptionDictionary = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descriptionDictionary["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                }
                            }
                            completed()
                        })
                    }
                } else {
                    self._description = "This pokemon doesn't have any descriptions"
                }
                if let evolutions = dictionary["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    if let nextEvolution = evolutions[0]["to"] as? String {
                        if nextEvolution.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvolution
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvolutionId = newString.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = nextEvolutionId
                                
                                if let levelExist = evolutions[0]["level"] {
                                    if let level = levelExist as? Int {
                                        self._nextEvolutionLevel = "\(level)"
                                    }
                                }
                            } else {
                                self._nextEvolutionLevel = ""
                            }
                        }
                    }
                }
                completed()
            }
        }
    }
}
