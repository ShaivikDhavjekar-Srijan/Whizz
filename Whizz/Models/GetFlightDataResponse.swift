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
    
    init(flightDate: String, flightStatus: String, departure: DepArr, arrival: DepArr, airline: Airline, flight: Flight){
        self.flightDate = flightStatus
        self.flightStatus = flightStatus
        self.departure = departure
        self.arrival = arrival
        self.airline = airline
        self.flight = flight
        
    }
}

struct DepArr: Codable, Equatable {
    let airport, timezone, iata: String?
    let delay: Int?
    let scheduled, actual: String?

    enum CodingKeys: String, CodingKey {
        case airport, timezone, iata, delay, scheduled, actual
    }
    
    init(airport: String, timezone: String, iata: String, delay:Int?, scheduled:String, actual:String?){
        self.airport = airport
        self.timezone = timezone
        self.iata = iata
        self.delay = delay
        self.scheduled = scheduled
        self.actual = actual
    }
}

struct Airline: Codable, Equatable {
    let name, iata, icao: String?
    
    enum CodingKeys: String, CodingKey {
        case name, iata, icao
    }
    
    init(name: String, iata: String, icao: String){
        self.name = name
        self.iata = iata
        self.icao = icao
        
    }
}

struct Flight: Codable, Equatable {
    let number, iata, icao: String?
    
    enum CodingKeys: String, CodingKey {
        case number, iata, icao
    }
    
    init(number: String, iata: String, icao: String){
        self.number = number
        self.iata = iata
        self.icao = icao
    }
    
}
