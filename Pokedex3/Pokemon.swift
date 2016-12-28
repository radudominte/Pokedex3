//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Radu Dominte on 22/12/16.
//  Copyright © 2016 Radu Dominte. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokemonId: Int!
    
    var name: String {
        
        return _name
    }
    
    var pokemonId: Int {
        
        return _pokemonId
    }
    
    init(name:String, pokemonId: Int) {
        
        self._name = name
        self._pokemonId = pokemonId
    }
    
    
}
