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
    
}

//12
extension SearchFlightsService {
    
    //13
    func getAirportData(query:String) async throws -> GetAirportDataResponse? {
        return nil
    }
    
}

//12
struct SearchFlightsServiceImpl: SearchFlightsService {
    
    //13
    func getAirportData(query:String) async throws -> GetAirportDataResponse? {
        return nil
    }
    
}

