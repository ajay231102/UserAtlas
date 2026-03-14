//
//  UserListingViewModel.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 14/03/26.
//

import Foundation

final class UserListingViewModel {
    
    private(set) var users: [UserDetail] = []
    
    var onDataReload: (() -> Void)?
    var onError: ((String) -> Void)?
    var onLoadingStateChange: ((Bool) -> Void)?
    
    private let cacheKey = "user_list_response"
    
    func fetchUsers(forceRefresh: Bool = false) {
        
        if !forceRefresh,
           let cachedResponse: UserDetailListResponse = UserCacheManager.shared.getObject(forKey: cacheKey,
                                                                                           type: UserDetailListResponse.self) {
            self.users = cachedResponse.users
            self.onDataReload?()
            return
        }
        
        onLoadingStateChange?(true)
        
        UserDetailListRequest.shared.fetchUsers { [weak self] result in
            guard let self = self else { return }
            
            self.onLoadingStateChange?(false)
            
            switch result {
            case .success(let response):
                self.users = response.users
                UserCacheManager.shared.save(response, forKey: self.cacheKey)
                self.onDataReload?()
                
            case .failure(let error):
                self.onError?(self.getErrorMessage(error))
            }
        }
    }
    
    func numberOfRows() -> Int {
        users.count
    }
    
    func user(at index: Int) -> UserDetail {
        users[index]
    }
    
    private func getErrorMessage(_ error: APIError) -> String {
        switch error {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .invalidStatusCode(let code):
            return "Status code: \(code)"
        case .noData:
            return "No data found"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        }
    }
}
