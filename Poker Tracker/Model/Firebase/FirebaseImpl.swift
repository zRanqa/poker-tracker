//
//  FirebaseImpl.swift
//  a2-s4092185-s4008144
//
//  Created by Jonathan Dummett on 8/10/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


func savePlayerDetails(playerDetails: PlayerDetails) async throws {
    
    let db = Firestore.firestore()
    
    do {
        try db.collection("playerDetails")
            .document(playerDetails.id.uuidString)
            .setData(from: playerDetails) { error in
                if let error = error {
                    print("Firestore write error: \(error.localizedDescription)")
                } else {
                    print("Booking saved successfully.")
                }
            }
    } catch {
        print("Encoding error")
    }
}

func loadAllPlayerDetails() async throws -> [PlayerDetails] {
    let db = Firestore.firestore()
    
    let snapshot = try await db.collection("playerDetails")
        .getDocuments()

    let playerDetails = try snapshot.documents.map { document in
        try document.data(as: PlayerDetails.self)
    }

    return playerDetails
}

func doesPlayerDetailsExist(name: String) async throws -> Bool {
    let playerDetails = try await loadAllPlayerDetails()
    
    if playerDetails.contains(where: { $0.name == name }) {
        return true
    } else {
        return false
    }
}

func saveNightEntry(nightEntry: NightEntry) async throws {
    let db = Firestore.firestore()
    
    let firebaseNightEntry: FirebaseNightEntry = nightEntry.toFirebaseNightEntry
    
    do {
        try db.collection("nightEntries")
            .document(firebaseNightEntry.id.uuidString)
            .setData(from: firebaseNightEntry) { error in
                if let error = error {
                    print("Firestore write error: \(error.localizedDescription)")
                } else {
                    print("Booking saved successfully.")
                }
            }
    } catch {
        print("Encoding error")
    }
}

func loadAllNightEntries() async throws -> [NightEntry] {
    let db = Firestore.firestore()
    
    let snapshot = try await db.collection("nightEntries")
        .getDocuments()
    
    let firebaseNightEntries = try snapshot.documents.map { document in
        try document.data(as: FirebaseNightEntry.self)
    }
    
    let nightEntries: [NightEntry] = firebaseNightEntries.map(\.toNightEntry)
    
    return nightEntries
}

//func saveUserDetails(_ userDetails: UserDetails) async throws {
//    
//    let db = Firestore.firestore()
//    let firestoreDetails = FirestoreUserDetails(from: userDetails)
//    
//    do {
//        try db.collection("users")
//            .document(userDetails.email)
//            .setData(from: firestoreDetails) { error in
//                if let error = error {
//                    print("Firestore write error: \(error.localizedDescription)")
//                } else {
//                    print("UserDetails saved successfully.")
//                }
//            }
//            
//    } catch {
//        print("Encoding error")
//    }
//}

//func loadUserDetails(for email: String) async throws -> FirestoreUserDetails? {
//    
//    let db = Firestore.firestore()
//    
//    let snapshot = try await db.collection("users")
//        .whereField("email", isEqualTo: email)
//        .getDocuments()
//
//    if snapshot.documents.isEmpty {
//        return nil
//    }
//    
//    let document = snapshot.documents[0]
//    let firestoreDetails = try document.data(as: FirestoreUserDetails.self)
//    return firestoreDetails
//
//}
//
