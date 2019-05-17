//
//  Player.swift
//  FinalProjectIOS
//
//  Created by Kristopher Vala on 2019-04-17.
//  Copyright © 2019 dev. All rights reserved.
//

import UIKit

class Player {

    var name: String
    var score: Int
    init?(name: String, score: Int)
    {
    
    guard !name.isEmpty else{
    return nil
    }
    
    self.name = name
    self.score = score
    }
    
}
