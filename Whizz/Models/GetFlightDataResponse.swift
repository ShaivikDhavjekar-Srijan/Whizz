//
//  GetFlightDataResponse.swift
//  Whizz
//
//  Created by Shaivik Dhavjekar on 07/11/22.
//

import Foundation

struct GetFlightDataResponse: Codable {
    
}

struct FlightData {
    let flightDate, flightStatus: String
    let departure: Departure
    let arrival: Arrival
    let airline: Airline
    let flight: Flight
    let aircraft, live: String?
    
//    init() {}
    
    enum CodingKeys: String, CodingKey {
        case flightDate = "flight_date"
        case flightStatus = "flight_status"
        case departure, arrival, airline, flight, aircraft, live
    }
}

struct Departure {
    let airport, timezone, iata, icao, terminal: String
    let gate: String?
    let delay: Int?
    let scheduled, estimated, actual, estimatedRunway, actualRunway: String

    enum CodingKeys: String, CodingKey {
        case airport, timezone, iata, icao, terminal, gate, delay, scheduled, estimated, actual
        case estimatedRunway = "estimated_runway"
        case actualRunway = "actual_runway"
    }
}

struct Arrival {
    let airport, timezone, iata, icao, terminal: String
    let gate: String?
    let baggage: String
    let delay: Int?
    let scheduled, estimated, actual, estimatedRunway, actualRunway: String

    enum CodingKeys: String, CodingKey {
        case airport, timezone, iata, icao, terminal, gate, delay, scheduled, estimated, actual
        case estimatedRunway = "estimated_runway"
        case actualRunway = "actual_runway"
    }
}

struct Airline {
    let name, iata, icao: String
}

struct Flight {
    let number, iata, icao: String
    let codeshared: Codeshared
}

struct Codeshared: Codable {
    let airlineName, airlineIata, airlineIcao, flightNumber, flightIata, flightIcao: String

    enum CodingKeys: String, CodingKey {
        case airlineName = "airline_name"
        case airlineIata = "airline_iata"
        case airlineIcao = "airline_icao"
        case flightNumber = "flight_number"
        case flightIata = "flight_iata"
        case flightIcao = "flight_icao"
    }
}
