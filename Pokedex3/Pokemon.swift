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
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonUrl: String!
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
        }
        return _description
    }
    
    var type: String {
        
        if _type == nil {
            
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            
            _defense = ""
        }
        return _defense
    }
    
    var height: String! {
        
        if _height == nil {
            
            _height = ""
        }
        return _height
    }

    var weight: String {
        
        if _weight == nil {
            
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        
        if _attack == nil {
            
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String {
        
        if _nextEvolutionTxt == nil {
            
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
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
    
    var pokemonId: Int {
        
        return _pokemonId
    }
    
    init(name:String, pokemonId: Int) {
        
        self._name = name
        self._pokemonId = pokemonId
        
        self._pokemonUrl = "\(BASE_URL)\(API_URL)\(self._pokemonId!)/"
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
                
                if let types = dict["types"] as? [Dictionary<String,String>], types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    print(self._type)
                }else{
                    
                    self._type = ""
                }
                
                if let descriptionArray = dict["descriptions"] as? [Dictionary<String, String>], descriptionArray.count > 0 {
                    
                    let url = descriptionArray[0]["resource_uri"]
                    
                    let descriptionURL = "\(BASE_URL)\(url!)"
                    
                    Alamofire.request(descriptionURL).responseJSON(completionHandler: { (response) in
                        
                        if let descriptionDict = response.result.value as? Dictionary<String, AnyObject> {
                            
                            if let description = descriptionDict["description"] as? String {
                                
                                let newDescription_1 = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                let newDescription_2 = newDescription_1.replacingOccurrences(of: "Pokmon", with: "Pokemon")
                                
                                self._description = newDescription_2
                            }
                        }
                        completed()
                    })
                }else{
                    
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    
                    if let nextEvolution = evolutions[0]["to"] as? String {
                        
                        if nextEvolution.range(of: "mega") == nil {
                            
                            self._nextEvolutionName = nextEvolution
                            
                            if let resource_uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newString = resource_uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvolutionId = newString.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvolutionId
                                
                                if let levelExist = evolutions[0]["level"] {
                                    
                                    if let level = levelExist as? Int {
                                        
                                        self._nextEvolutionLevel = "\(level)"
                                    }
                                }else{
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                }
                print(self.nextEvolutionLevel)
                print(self.nextEvolutionName)
                print(self.nextEvolutionId)
            }
            completed()
        }
    }
    
    
}
