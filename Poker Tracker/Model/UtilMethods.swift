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
    validateName: Bool = false,
    validatePositive: Bool = false
) -> Status {
    if input == "" {
        return Status(isSuccess: false, message:"All fields required to be filled out")
    }
    
    if validateName && input.count > 16 {
        return Status(isSuccess: false, message: "Name cannot be longer than 16 characters")
    }
    
    if validateInt {
        guard let intValue = Int(input) else {
            return Status(isSuccess: false, message:"Input must be an number")
        }
        
        if validatePositive {
            if intValue < 0 {
                return Status(isSuccess: false, message: "Input must be a positive number")
            }
        }
    }
    
    if validateDouble {
        guard let doubleValue = Double(input) else {
            return Status(isSuccess: false, message:"Input must be an number")
        }
        
        if validatePositive {
            if doubleValue < 0 {
                return Status(isSuccess: false, message: "Input must be a positive number")
            }
        }
    }
    
    return Status(isSuccess: true, message: "")
}
