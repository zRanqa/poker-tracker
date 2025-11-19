//
//  PlayerTotals.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 31/10/2025.
//

import Foundation

struct PlayerTotals: Identifiable {
    var id = UUID()
    var playerDetails: PlayerDetails
    var buyIns: Int = 0
    
    var totalMoney: Double
    var totalGames: Int = 0
    var totalWins: Int = 0
    var totalLosses: Int = 0
    
    var winPercentage: Double = 0
    var lossPercentage: Double = 0
    
    var winStreak: Int = 0
    var stopWinStreak: Bool = true
    
    var lossStreak: Int = 0
    var stopLossStreak: Bool = true
    
    var mostMoneyWon: Double = 0
    
    var mostMoneyLost: Double = 0
    
}

func calculateTotals() async -> [PlayerTotals] {
    var playerTotals: [PlayerTotals] = []
    do {
        let nightEntries = try await loadAllNightEntries().sorted(by: { $0.date > $1.date })
        let allPlayerDetails = try await loadAllPlayerDetails()
        
        // Initialise the player totals list
        for player in allPlayerDetails {
            playerTotals.append(PlayerTotals(playerDetails: player, totalMoney: 0))
        }
        
        for night in nightEntries {
            for playerEntry in night.playerEntries {
                if let index = playerTotals.firstIndex(where: { $0.playerDetails.id == playerEntry.playerDetails.id }) {
                    // Total money
                    playerTotals[index].totalMoney += playerEntry.endingAmount - playerEntry.startingAmount
                    
                    // Total games
                    playerTotals[index].totalGames += 1
                    
                    // Total wins
                    if playerEntry.endingAmount >= playerEntry.startingAmount {
                        playerTotals[index].totalWins += 1
                    }
                    
                    // Total losees
                    if playerEntry.endingAmount < playerEntry.startingAmount {
                        playerTotals[index].totalLosses += 1
                    }
                    
                    // Win percentage
                    playerTotals[index].winPercentage = Double(playerTotals[index].totalWins) / Double(playerTotals[index].totalGames) * 100
                    
                    // Loss percentage
                    playerTotals[index].lossPercentage = Double(playerTotals[index].totalLosses) / Double(playerTotals[index].totalGames) * 100
                    
                    // Win Streak
                    if playerTotals[index].stopWinStreak && (playerEntry.endingAmount > playerEntry.startingAmount) {
                        playerTotals[index].winStreak += 1
                    }
                    else {
                        playerTotals[index].stopWinStreak = false
                    }
                    
                    // Loss Streak
                    if playerTotals[index].stopLossStreak && (playerEntry.endingAmount < playerEntry.startingAmount) {
                        playerTotals[index].lossStreak += 1
                    }
                    else {
                        playerTotals[index].stopLossStreak = false
                    }
                    
                    // Buy Ins
                    playerTotals[index].buyIns += playerEntry.buyIns
                    
                    // Most Money Won
                    if playerEntry.endingAmount - playerEntry.startingAmount > playerTotals[index].mostMoneyWon {
                        playerTotals[index].mostMoneyWon = playerEntry.endingAmount - playerEntry.startingAmount
                    }
                    
                    // Most money Lost
                    if playerEntry.endingAmount - playerEntry.startingAmount < playerTotals[index].mostMoneyLost {
                        playerTotals[index].mostMoneyLost = playerEntry.endingAmount - playerEntry.startingAmount
                    }
                    
                    
                }
            }
        }
        
        return playerTotals
    }
    catch {
        print("Error while calculating totals: \(error)")
        return []
    }
}

func playerTotalAttrNameToDesc(attr: String) -> String {
    switch attr {
    case "buyIns":
        return "Buy Ins"
    case "totalMoney":
        return "Total Money"
    case "totalGames":
        return "Total Games"
    case "totalWins":
        return "Total Wins"
    case "totalLosses":
        return "Total Losses"
    case "winPercentage":
        return "Win Percentage"
    case "lossPercentage":
        return "Loss Percentage"
    case "winStreak":
        return "Win Streak"
    case "lossStreak":
        return "Loss Streak"
    case "mostMoneyWon":
        return "Most Money Won"
    case "mostMoneyLost":
        return "Most Money Lost"
    default:
        return "-Missing \(attr)-"
    }
}



func getPlayerTotalAttributes() -> [String : String] {
    var attrList: [String : String] = [:]
    
    let playerTotal = PlayerTotals(playerDetails: getTestPlayerDetails(), totalMoney: 0)
    let mirror = Mirror(reflecting: playerTotal)
    
    let ignoreList = [
        "playerDetails",
        "id",
        "stopLossStreak",
        "stopWinStreak"
    ]

    for child in mirror.children {
        if let propertyName = child.label {
            if !ignoreList.contains(propertyName) {
                attrList[propertyName] = playerTotalAttrNameToDesc(attr: propertyName)
            }
        }
    }
    
    
    return attrList
}
