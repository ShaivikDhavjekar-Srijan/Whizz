//
//  GetAirportDataResponse.swift
//  Whizz
//
//  Created by Shaivik Dhavjekar on 04/11/22.
//

import Foundation

//20
//For SearchFlightsState to be Equatable -> AirportData has to be equatable
struct GetAirportDataResponse: Codable, Equatable {
    let success: Bool?
    let data: [Airport]?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case success, data, message
    }
    
    //25
    init(success: Bool, data: [Airport], message: String?) {
        self.success = success
        self.data = data
        self.message = message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decodeIfPresent(Bool.self, forKey: .success)
        data = try container.decodeIfPresent([Airport].self, forKey: .data)
        message = try container.decodeIfPresent(String.self, forKey: .message)
    }
}

struct Airport: Codable, Equatable {
    let iataCode, name, city, country: String?
    
    enum CodingKeys: String, CodingKey {
        case iataCode = "iata_code"
        case name, city, country
    }
    
    init(iataCode: String, name: String, city: String, country: String) {
        self.iataCode = iataCode
        self.name = name
        self.city = city
        self.country = country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        iataCode = try container.decodeIfPresent(String.self, forKey: .iataCode)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        country = try container.decodeIfPresent(String.self, forKey: .country)
    }
}
