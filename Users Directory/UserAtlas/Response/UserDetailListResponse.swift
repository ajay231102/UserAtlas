//
//  UserDetailListResponse.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 14/03/26.
//

import Foundation

final class UserDetailListResponse: Codable {
    let users: [UserDetail]
    let info: ResponseInfo
}

final class UserDetail: Codable {
    let gender: String
    let name: UserName
    let location: UserLocation
    let email: String
    let login: UserLogin
    let dob: UserDOB
    let registered: UserRegistered
    let phone: String
    let cell: String
    let id: UserID
    let picture: UserPicture
    let nat: String
}

final class UserName: Codable {
    let title: String
    let first: String
    let last: String
    
    var fullName: String {
        "\(title) \(first) \(last)"
    }
}

final class UserLocation: Codable {
    let street: UserStreet
    let city: String
    let state: String
    let country: String
    let postcode: String
    let coordinates: UserCoordinates
    let timezone: UserTimezone
    
    var fullAddress: String {
        "\(street.number) \(street.name), \(city), \(state), \(country) - \(postcode)"
    }
    
    enum CodingKeys: String, CodingKey {
        case street
        case city
        case state
        case country
        case postcode
        case coordinates
        case timezone
    }
    
    init(
        street: UserStreet,
        city: String,
        state: String,
        country: String,
        postcode: String,
        coordinates: UserCoordinates,
        timezone: UserTimezone
    ) {
        self.street = street
        self.city = city
        self.state = state
        self.country = country
        self.postcode = postcode
        self.coordinates = coordinates
        self.timezone = timezone
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.street = try container.decode(UserStreet.self, forKey: .street)
        self.city = try container.decode(String.self, forKey: .city)
        self.state = try container.decode(String.self, forKey: .state)
        self.country = try container.decode(String.self, forKey: .country)
        self.coordinates = try container.decode(UserCoordinates.self, forKey: .coordinates)
        self.timezone = try container.decode(UserTimezone.self, forKey: .timezone)
        
        if let intPostcode = try? container.decode(Int.self, forKey: .postcode) {
            self.postcode = String(intPostcode)
        } else {
            self.postcode = try container.decode(String.self, forKey: .postcode)
        }
    }
}

final class UserStreet: Codable {
    let number: Int
    let name: String
}

final class UserCoordinates: Codable {
    let latitude: String
    let longitude: String
}

final class UserTimezone: Codable {
    let offset: String
    let description: String
}

final class UserLogin: Codable {
    let uuid: String
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

final class UserDOB: Codable {
    let date: String
    let age: Int
}

final class UserRegistered: Codable {
    let date: String
    let age: Int
}

final class UserID: Codable {
    let name: String
    let value: String?
}

final class UserPicture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

final class ResponseInfo: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}
