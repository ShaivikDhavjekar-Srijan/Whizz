//
//  GetFlightDataResponse.swift
//  Whizz
//
//  Created by Shaivik Dhavjekar on 07/11/22.
//

import Foundation

struct GetFlightDataResponse: Codable, Equatable {
    let flightDate, flightStatus: String?
    let departure: DepArr?
    let arrival: DepArr?
    let airline: Airline?
    let flight: Flight?
    
//    init() {}
    
    enum CodingKeys: String, CodingKey {
        case flightDate = "flight_date"
        case flightStatus = "flight_status"
        case departure, arrival, airline, flight
    }
}

struct DepArr: Codable, Equatable {
    let airport, timezone, iata: String?
    let delay: Int?
    let scheduled, actual: String?

    enum CodingKeys: String, CodingKey {
        case airport, timezone, iata, delay, scheduled, actual
    }
}

struct Airline: Codable, Equatable {
    let name, iata, icao: String?
    
    enum CodingKeys: String, CodingKey {
        case name, iata, icao
    }
}

struct Flight: Codable, Equatable {
    let number, iata, icao: String?
    
    enum CodingKeys: String, CodingKey {
        case number, iata, icao
    }
}
