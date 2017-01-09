//
//  PokemonDetailVC.swift
//  Pokedex3
//
//  Created by Radu Dominte on 29/12/16.
//  Copyright © 2016 Radu Dominte. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexId: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evolabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.capitalized
        
        let image = UIImage(named: "\(pokemon.pokemonId)")
        mainImage.image = image
        currentEvoImage.image = image
        pokedexId.text = "\(pokemon.pokemonId)"
        
        pokemon.downloadPokemonDetail() {
            // Whatever we write will only be called after the network call is complete!
            print("completed")
            self.updateUI()
            
        }
    }
    
    
    func updateUI() {
        
        typeLabel.text = pokemon.type
        baseAttackLabel.text = pokemon.attack
        weightLabel.text = pokemon.weight
        heightLabel.text = pokemon.height
        defenseLabel.text = pokemon.defense
        descriptionLabel.text = pokemon.description

        if pokemon.nextEvolutionId == "" {
            
            evolabel.text = "No Evoltion"
            nextEvoImage.isHidden = true
        }else{
            
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: "\(pokemon.nextEvolutionId)")
            
            let nextEvolutionDescription = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            evolabel.text = nextEvolutionDescription
        }
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
