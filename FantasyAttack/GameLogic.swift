//
//  GameLogic.swift
//  FantasyAttack
//
//  Created by oussama Hichri on 15/3/2023.
//

import Foundation

enum AttackType:String {
    case miss = "Miss !"
    case normal = ""
    case critical = "Critical !"
}

// Step 1: Determine the order of attack
private func determineAttackOrder(_ player1: Character, _ player2: Character) -> (Character, Character) {
    return player1.speed >= player2.speed ? (player1, player2) : (player2, player1)
}

// Step 2: Determine the type of attack
private func determineAttackType(attacker: Character) -> AttackType {
    let baseCriticalChance = 20
    let luckBonus = attacker.luck
    let modifiedCriticalChance = baseCriticalChance + luckBonus
    let randomNumber = Int.random(in: 1...100)
    
    if randomNumber <= modifiedCriticalChance {
        return .critical
    } else if randomNumber <= (modifiedCriticalChance + 20) {
        return .miss
    } else {
        return .normal
    }
}


// Step 3: Calculate total attack
private func calculateTotalAttack(_ character: Character, _ attackType: AttackType) -> Int {
    let constant: Int
    switch attackType {
    case .miss:
        constant = 0
    case .normal:
        constant = 1
    case .critical:
        constant = 3
    }
    return character.attackBasePoints * constant
}

// Step 4: Calculate damage
private func calculateInflictedDamage(_ totalAttack: Int, _ character: Character) -> Int {
    let damage = totalAttack - character.defense
    return damage > 0 ? damage : 0
}

// Step 5: Reduce target's life
private func reduceLife(_ character: inout Character, _ damage: Int) {
    character.life = max(character.life - damage, 0)
}
// Step 6: Log the results
func playRound(_ inputFighters: [Character]) {
    guard inputFighters.count >= 2 else {
        Logger.error("At least two fighters are required.")
        return
    }
    
    var fighters = [determineAttackOrder(inputFighters[0], inputFighters[1]).0, determineAttackOrder(inputFighters[0], inputFighters[1]).1] // Determine the order based on speed

    Logger.info("Start GAME\n")

    var fighterLives: [String: Int] = [:]

    for (index, fighter) in fighters.enumerated() {
        Logger.info("Fighter\(index + 1): \(fighter.description)")
        fighterLives[fighter.name] = fighter.life
    }

    Logger.info("")

    var round = 1
    var activeFighterIndex = 0

    repeat {
        let attacker = fighters[activeFighterIndex]
        let defenderIndex = (activeFighterIndex + 1) % fighters.count
        var defender = fighters[defenderIndex]

        let attackType = determineAttackType(attacker: attacker)
        let attackPoints = calculateTotalAttack(attacker, attackType)
        let damage = calculateInflictedDamage(attackPoints, defender)

        reduceLife(&defender, damage)
        fighterLives[defender.name] = defender.life
        Logger.info("Round \(round): \(attackType.rawValue)")
        Logger.info("\(attacker.name) inflicts \(damage) of damage")
        Logger.info("\(defender.name) has \(fighterLives[defender.name] ?? 0) points of life left\n")

        if (fighterLives[defender.name] ?? 0) <= 0 {
            Logger.info("\(defender.name) is defeated!\n")
            fighters.remove(at: defenderIndex)
            fighterLives.removeValue(forKey: defender.name)
        } else {
            activeFighterIndex = defenderIndex
        }

        Logger.debug("DEBUG: Round \(round), ActiveFighterIndex: \(activeFighterIndex), FighterLives: \(fighterLives)")

        round += 1
    } while fighters.count > 1

    let winner = fighters.first!
    Logger.info("\(winner.name) wins!!!\n")
    Logger.info("END GAME")
}
