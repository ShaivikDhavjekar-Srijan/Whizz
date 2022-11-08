//
//  SearchFlightsService.swift
//  Whizz
//
//  Created by Shaivik Dhavjekar on 04/11/22.
//

import Foundation

//9
protocol SearchFlightsService {
    
    //10
    func getAirportData(query:String) async throws -> GetAirportDataResponse?
    
    func getFlightData(from:String, to:String, departure:String) async throws -> GetFlightDataResponse?
    
}

//12
extension SearchFlightsService {
    
    //13
    func getAirportData(query:String) async throws -> GetAirportDataResponse? {
        return nil
    }
    
    func getFlightData(from: String, to: String, departure: String) async throws -> GetFlightDataResponse? {
        return nil
    }
    
}

//12
struct SearchFlightsServiceImpl: SearchFlightsService {
    
    var networkManager:NetworkManager?
    
    init(networkManager:NetworkManager){
        self.networkManager = networkManager
    }

    //13
    func getAirportData(query:String) async throws -> GetAirportDataResponse? {
        return try await networkManager!.performRequestWithContinuation(serviceType: .getAiportData(param:[ApiConstants.ACCESS_KEY:ApiConstants.API_KEY, ApiConstants.QUERY:query]), type: GetAirportDataResponse.self)
    }
    
    func getFlightData(from: String, to: String, departure: String) async throws -> [GetFlightDataResponse]? {
        return try await networkManager!.performRequestWithContinuation(serviceType: .getFlightData(param:[ApiConstants.ACCESS_KEY:ApiConstants.API_KEY, ApiConstants.FROM:from, ApiConstants.TO:to, ApiConstants.DEPARTURE:departure]), type: [GetFlightDataResponse].self)
    }
    
}

