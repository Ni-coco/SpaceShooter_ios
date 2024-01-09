//
//  Scenario.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 09/01/2024.
//

import SpriteKit

class Scenario {
    
    let viewSize: CGRect
    
    var indexLvl = 1
    var waveCount = 1
    var difficulty = 1
    var healthBoss = 0

    var scoutHealth = 2
    var fighterHealth = 5
    var frigateHealth = 8
    var dreadnoughtHealth = 20

    init(viewSize: CGRect) {
        self.viewSize = viewSize
    }

    func getLevel() -> [Enemies] {
        switch indexLvl {
        case 1:
            return level1()
        case 2:
            return level2()
        case 3:
            return level3()
        case 4:
            return level4()
        case 5:
            return level5()
        default:
            return []
        }
    }

    func level1() -> [Enemies] {
        var listEnemies = [Enemies]()
        for _ in 0..<difficulty {
            listEnemies.append(Scout(viewSize: viewSize, health: (scoutHealth + (scoutHealth * self.getDifficultyHealth()))))
        }
        indexLvl += 1
        waveCount += 1
        return listEnemies
    }

    func level2() -> [Enemies] {
        var listEnemies = [Enemies]()
        for _ in 0..<difficulty {
            listEnemies.append(Scout(viewSize: viewSize, health: (scoutHealth + (scoutHealth * self.getDifficultyHealth()))))
            listEnemies.append(Fighter(viewSize: viewSize, health: fighterHealth + (fighterHealth * getDifficultyHealth())))
        }
        indexLvl += 1
        waveCount += 1
        return listEnemies
    }

    func level3() -> [Enemies] {
        var listEnemies = [Enemies]()
        for _ in 0..<difficulty {
            listEnemies.append(Scout(viewSize: viewSize, health: (scoutHealth + (scoutHealth * self.getDifficultyHealth()))))
            listEnemies.append(Frigate(viewSize: viewSize, health: frigateHealth + (frigateHealth * self.getDifficultyHealth())))
        }
        indexLvl += 1
        waveCount += 1
        return listEnemies
    }

    func level4() -> [Enemies] {
        var listEnemies = [Enemies]()
        for _ in 0..<difficulty {
            listEnemies.append(Scout(viewSize: viewSize, health: (scoutHealth + (scoutHealth * self.getDifficultyHealth()))))
            listEnemies.append(Scout(viewSize: viewSize, health: (scoutHealth + (scoutHealth * self.getDifficultyHealth()))))
            listEnemies.append(Fighter(viewSize: viewSize, health: fighterHealth + (fighterHealth * getDifficultyHealth())))
            listEnemies.append(Frigate(viewSize: viewSize, health: frigateHealth + (frigateHealth * self.getDifficultyHealth())))
        }
        indexLvl += 1
        waveCount += 1
        return listEnemies
    }

    func level5() -> [Enemies] {
        var listEnemies = [Enemies]()
        healthBoss = 0
        if waveCount % 10 == 0 {
            for _ in 0..<difficulty {
                listEnemies.append(Dreadnought(viewSize: viewSize, health: dreadnoughtHealth * getDifficultyHealth()))
            }
        } else {
            listEnemies.append(Scout(viewSize: viewSize, health: scoutHealth + (scoutHealth * getDifficultyHealth())))
            listEnemies.append(Fighter(viewSize: viewSize, health: fighterHealth + (fighterHealth * getDifficultyHealth())))
            listEnemies.append(Dreadnought(viewSize: viewSize, health: dreadnoughtHealth + (dreadnoughtHealth * getDifficultyHealth())))
        }
        indexLvl = 1
        waveCount += 1
        difficulty += 1
        return listEnemies
    }
    
    func getDifficultyHealth() -> Int {
        return self.difficulty - 1
    }
    
    func getWave() -> Int {
        return self.waveCount
    }
}
