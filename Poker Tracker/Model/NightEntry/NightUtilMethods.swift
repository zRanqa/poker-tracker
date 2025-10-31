//
//  UtilMethods.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 31/10/2025.
//

import Foundation

func getTestNightEntry() -> NightEntry {
    return NightEntry(date: Date(), playerEntries: [getTestPlayerEntry(), getTestPlayerEntry()])
}

func getNightsFromData() async -> [NightEntry]  {
    guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
        print("data.json not found")
        return []
    }
    
    do {
        let data = try Data(contentsOf: url)
        
        guard let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            print("JSON not an array")
            return []
        }
        
        var nightEntries: [NightEntry] = []
        var playerDetails: [PlayerDetails] = try await loadAllPlayerDetails()
        
        for nightDict in jsonArray {
            guard let date = nightDict["date"] as? String,
                  let players = nightDict["players"] as? [[String: Any]] else {
                continue
            }
            
            var playerEntries: [PlayerEntry] = []
            
            for playerDict in players {
                guard let name = playerDict["name"] as? String,
                      let start = playerDict["start"] as? Double,
                      let end = playerDict["end"] as? Double,
                      let buyIns = playerDict["buyIns"] as? Int else {
                    continue
                }
                
                var selectedPlayerDetails: PlayerDetails? = nil
                
                for playerDetail in playerDetails {
                    if playerDetail.name == name {
                        selectedPlayerDetails = playerDetail
                        break
                    }
                }
                
                if selectedPlayerDetails == nil {
                    selectedPlayerDetails = PlayerDetails(name: name)
                }
                
                let playerEntry = PlayerEntry(
                    playerDetails: selectedPlayerDetails!,
                    startingAmount: start,
                    endingAmount: end,
                    buyIns: buyIns
                )
                
                playerEntries.append(playerEntry)
            }
            
            let nightEntry = NightEntry(date: getDateFromString(dateString: date), playerEntries: playerEntries)
            nightEntries.append(nightEntry)
        }
        
        print("Loaded \(nightEntries.count) nights")
        return nightEntries
        
    } catch {
        print("Failed to parse JSON: \(error.localizedDescription)")
        return []
    }
}

