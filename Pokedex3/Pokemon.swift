//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Radu Dominte on 22/12/16.
//  Copyright © 2016 Radu Dominte. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokemonId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonUrl: String!
    
    
    var name: String {
        
        return _name
    }
    
    var pokemonId: Int {
        
        return _pokemonId
    }
    
    init(name:String, pokemonId: Int) {
        
        self._name = name
        self._pokemonId = pokemonId
        
        self._pokemonUrl = "\(URL_BASE)\(URL_API)\(self._pokemonId!)/"
    }
    
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonUrl).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
            }
        }
    }
    
    
}
