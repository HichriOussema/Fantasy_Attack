//
//  Character.swift
//  FantasyAttack
//
//  Created by oussama Hichri on 15/3/2023.
//

import Foundation

protocol Fighter {
    var name: String { get }
    var attackBasePoints: Int { get }
    var defense: Int { get }
    var speed: Int { get }
    var life: Int { get }
    var luck: Int { get }
}

class Character:Fighter {
    let name: String
    let attackBasePoints: Int
    let defense: Int
    let speed: Int
    var life: Int
    let luck: Int

    init(name: String, attackBasePoints: Int, defense: Int, speed: Int, life: Int, luck: Int) {
        self.name = name
        self.attackBasePoints = attackBasePoints
        self.defense = defense
        self.speed = speed
        self.life = life
        self.luck = luck
    }
}

extension Character {
    var description: String {
        return "\(name), attack: \(attackBasePoints), defense: \(defense), speed: \(speed), life: \(life), luck: \(luck)"
    }
}
