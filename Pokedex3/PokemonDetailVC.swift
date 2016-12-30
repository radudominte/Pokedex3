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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name
    }
    
}
