//
//  PostRequest.swift
//  Poker Tracker
//
//  Created by Jonathan Dummett on 21/12/2025.
//

import Foundation

func postRequest(to urlString: String, jsonBody: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
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

        guard let data = data, let responseString = String(data: data, encoding: .utf8) else {
            completion(.failure(NSError(domain: "Invalid response", code: 0)))
            return
        }

        completion(.success(responseString))
    }.resume()
}
