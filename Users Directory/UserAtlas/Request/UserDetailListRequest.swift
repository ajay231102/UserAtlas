//
//  UserDetailListRequest.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 14/03/26.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case noData
    case decodingError(Error)
}

final class UserDetailListRequest {
    
    static let shared = UserDetailListRequest()
    private init() {}
    
    private let baseURL = "https://randomuser.me/api/"
    
    func fetchUsers(count: Int = 20,
                    completion: @escaping (Result<UserDetailListResponse, APIError>) -> Void) {
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "results", value: "\(count)")
        ]
        
        guard let url = components?.url else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidStatusCode(httpResponse.statusCode)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(UserDetailListResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error)))
                }
            }
        }.resume()
    }
}
