//
//  GetAirportDataResponse.swift
//  Whizz
//
//  Created by Shaivik Dhavjekar on 04/11/22.
//

import Foundation

//11
struct GetAirportDataResponse: Codable {
    
}

//20
//For SearchFlightsState to be Equatable -> AirportData has to be equatable
struct AirportData: Codable, Equatable {
    let success: Bool
    let data: [Airport]
}

struct Airport: Codable, Equatable {
    let iataCode: String
    let name: String
    let city: String?
    let country: String

    enum CodingKeys: String, CodingKey {
        case iataCode = "iata_code"
        case name, city, country
    }
}
