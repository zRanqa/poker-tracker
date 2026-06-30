//
//  PlayerTotals.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 30/6/2026.
//
import Foundation

struct PlayerTotals: Identifiable, Equatable {
    var id: UUID
    var name: String
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
    
    var linePoints: [LinePoint] = []
    
    
    func value(for label: String) -> String {
        switch label {
        case "Buy Ins": return "\(buyIns)"
        case "Loss Percentage": return String(format: "%.1f%%", lossPercentage)
        case "Loss Streak": return "\(lossStreak)"
        case "Most Money Lost": return String(format: "$%.2f", mostMoneyLost)
        case "Most Money Won": return String(format: "$%.2f", mostMoneyWon)
        case "Total Games": return "\(totalGames)"
        case "Total Losses": return "\(totalLosses)"
        case "Total Money": return String(format: "$%.2f", totalMoney)
        case "Total Wins": return "\(totalWins)"
        case "Win Percentage": return String(format: "%.1f%%", winPercentage)
        case "Win Streak": return "\(winStreak)"
        default: return "—"
        }
    }
}

func calculateTotals(pokerGroup: PokerGroup) -> [PlayerTotals] {
    var playerTotals: [PlayerTotals] = []
    // Initialise the player totals list
    for groupMember in pokerGroup.groupMembers {
        playerTotals.append(PlayerTotals(id: groupMember.id, name: groupMember.name, totalMoney: 0))
    }
    
    for session in pokerGroup.pokerSessions {
        for sessionEntry in session.sessionEntries {
            if let index = playerTotals.firstIndex(where: { $0.id == sessionEntry.groupMember.id }) {
                // Total money
                playerTotals[index].totalMoney += sessionEntry.endAmount - sessionEntry.startAmount
                
                // Line Points
                let newLinePoint = LinePoint(date: session.date, value: sessionEntry.endAmount - sessionEntry.startAmount)
                playerTotals[index].linePoints.append(newLinePoint)
                
                // Total games
                playerTotals[index].totalGames += 1
                
                // Total wins
                if sessionEntry.endAmount >= sessionEntry.startAmount {
                    playerTotals[index].totalWins += 1
                }
                
                // Total losees
                if sessionEntry.endAmount < sessionEntry.startAmount {
                    playerTotals[index].totalLosses += 1
                }
                
                // Win percentage
                playerTotals[index].winPercentage = Double(playerTotals[index].totalWins) / Double(playerTotals[index].totalGames) * 100
                
                // Loss percentage
                playerTotals[index].lossPercentage = Double(playerTotals[index].totalLosses) / Double(playerTotals[index].totalGames) * 100
                
                // Win Streak
                if playerTotals[index].stopWinStreak && (sessionEntry.endAmount > sessionEntry.startAmount) {
                    playerTotals[index].winStreak += 1
                }
                else {
                    playerTotals[index].stopWinStreak = false
                }
                
                // Loss Streak
                if playerTotals[index].stopLossStreak && (sessionEntry.endAmount < sessionEntry.startAmount) {
                    playerTotals[index].lossStreak += 1
                }
                else {
                    playerTotals[index].stopLossStreak = false
                }
                
                // Buy Ins
                playerTotals[index].buyIns += sessionEntry.buyIns
                
                // Most Money Won
                if sessionEntry.endAmount - sessionEntry.startAmount > playerTotals[index].mostMoneyWon {
                    playerTotals[index].mostMoneyWon = sessionEntry.endAmount - sessionEntry.startAmount
                }
                
                // Most money Lost
                if sessionEntry.endAmount - sessionEntry.startAmount < playerTotals[index].mostMoneyLost {
                    playerTotals[index].mostMoneyLost = sessionEntry.endAmount - sessionEntry.startAmount
                }
                
                
            }
        }
    }
    
    // Reverse line points and calculate
    for i in playerTotals.indices {
        
        let lastDate = playerTotals[i].linePoints.last?.date ?? Date()
        let startPoint = LinePoint(date: lastDate, value: 0)
        
        playerTotals[i].linePoints.append(startPoint)
        playerTotals[i].linePoints.reverse()
        
        var totalMoney = 0.0
        for j in playerTotals[i].linePoints.indices {
            totalMoney = playerTotals[i].linePoints[j].value + totalMoney
            playerTotals[i].linePoints[j].value = totalMoney
        }
    }
    
    
    return playerTotals
}
