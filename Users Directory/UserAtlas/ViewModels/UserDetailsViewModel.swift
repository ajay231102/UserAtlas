//
//  UserDetailsViewModel.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 25/05/26.
//

import Foundation

final class UserDetailsViewModel {
    
    var user: UserDetail?
    
    var onDataReload: (() -> Void)?
    
    init(user: UserDetail? = nil) {
        self.user = user
    }
    
    func numberOfRows() -> Int {
        return self.getUserDetailsCellModels().count + 1
    }
    
    func user(at index: Int) -> UserContactDetailsTableViewCell.Model {
        let cellModel = self.getUserDetailsCellModels()
        return cellModel[index]
    }
    
    func getHeaderCellModel() -> UserContactDetailsHeaderTableViewCell.Model {
        return UserContactDetailsHeaderTableViewCell.Model(picture: user?.picture, name: user?.name.fullName)
    }
    
    private func getUserDetailsCellModels() -> [UserContactDetailsTableViewCell.Model] {
        var cellModels: [UserContactDetailsTableViewCell.Model] = []
        if let email = user?.email {
            cellModels.append(.init(detail: email, type: .email))
        }
        if let phone = user?.phone {
            cellModels.append(.init(detail: phone, type: .phone))
        }
        if let dob = user?.dob {
            let dobStr = "\(dob.date) (\(dob.age) Years)"
            cellModels.append(.init(detail: dobStr, type: .dob))
        }
        if let location = user?.location {
            cellModels.append(.init(detail: location.fullAddress, type: .address))
        }
        
        if let gender = user?.gender {
            cellModels.append(.init(detail: gender.capitalized, type: .gender))
        }
        
        return cellModels
        
    }
    
}
