//
//  APIUrl.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 23/6/2026.
//

let API_URL = "http://127.0.0.1:5000/api"

enum APIEndpoints {
    case login
}


func getApiUrl(endpoint: APIEndpoints) -> String {
    switch endpoint {
    case .login:
        return "\(API_URL)/login"
        
        
    }
}
