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
            }
            completed()
        }
    }
}
