//
//  Character.swift
//  RPG2
//
//  Created by AADITYA NARVEKAR on 5/29/16.
//  Copyright © 2016 Aaditya Narvekar. All rights reserved.
//

import Foundation

class Character {
    private var _name: String = "Regular Grunt"
    var name: String {
        return self._name
    }
    
    
    private var _healingPower: Int = 50
    var healingPower: Int {
        return self._healingPower
    }
    
    private var _attackPower: Int = 5
    var attackPower: Int {
        return self._attackPower
    }
    
    init(hp: Int, attackPwr: Int, name: String) {
        self._healingPower = hp
        self._attackPower = attackPwr
        self._name = name
    }
    
    func handleAttackAttempt(attackPower: Int) -> Bool {
        if self.healingPower > 0 {
            self._healingPower = self._healingPower - attackPower
            return true
        } else {
            return false
        }
    }
    
    func isAlive() -> Bool {
        return self._healingPower > 0
    }
    
    
    
}