//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Duc Lam on 7/20/17.
//  Copyright © 2017 Duc Lam. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexIdlLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvolutionImg: UIImageView!
    @IBOutlet weak var nextEvolutionImg: UIImageView!
    @IBOutlet weak var evolutionLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name.capitalized
        let image = UIImage(named: "\(pokemon.pokedexId)")
        pokemonImg.image = image
        
        currentEvolutionImg.image = image
        evolutionLbl.text = "\(pokemon.pokedexId)"
        

        pokemon.downloadPokemonDetails { 
            self.updateUI()
        }
    }
    func updateUI() {
        
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        pokedexIdlLbl.text = String(pokemon.pokedexId)
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            evolutionLbl.text = "No Evolutions"
            nextEvolutionImg.isHidden = true
            
        } else {
            nextEvolutionImg.isHidden = false
            nextEvolutionImg.image = UIImage(named: pokemon.nextEvolutionId)
            let string = "Next Evolution: \(pokemon.nextEvolutionName) @ LVL \(pokemon.nextEvolutionLevel)"
            evolutionLbl.text = string
        }
        
        
    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
}
