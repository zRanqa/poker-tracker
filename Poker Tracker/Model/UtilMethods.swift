//
//  UtilMethods.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 27/10/2025.
//

import Foundation

struct Status {
    var isSuccess: Bool
    var message: String
}

func validateInput(
    input: String,
    validateInt: Bool = false,
    validateDouble: Bool = false,
) -> Status {
    if input == "" {
        return Status(isSuccess: false, message:"All fields required to be filled out")
    }
    
    if validateInt {
        guard let intVar = Int(input) else {
            return Status(isSuccess: false, message:"Input must be an number")
        }
    }
    
    if validateDouble {
        guard let intVar = Double(input) else {
            return Status(isSuccess: false, message:"Input must be an number")
        }
    }
    
    return Status(isSuccess: true, message: "")
}
