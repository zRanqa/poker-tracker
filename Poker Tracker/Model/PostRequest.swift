//
//  PostRequest.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 21/12/2025.
//

import Foundation

enum API {
    static let baseURL = "http://127.0.0.1:5000/api/"

    case createVerificationCode
    case createAccount

    var url: String {
        switch self {
        case .createVerificationCode: return API.baseURL + "create-verification-code"
        case .createAccount: return API.baseURL + "create-account"
        }
    }
}


struct APIResponse: Codable {
    let status: String
    let message: String
    let data: String?
}

func postRequest(to urlString: String, jsonBody: [String: Any], completion: @escaping (Result<APIResponse, Error>) -> Void) {
    
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0)))
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody, options: [])
    } catch {
        completion(.failure(error))
        return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(NSError(domain: "No data", code: 0)))
            return
        }
        print(String(data: data, encoding: .utf8) ?? "invalid json")
        do {
            let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            completion(.success(apiResponse))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}
