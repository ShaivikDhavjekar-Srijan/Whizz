//
//  LocalisationProvider.swift
//  Swiko
//
//  Created by Srijan on 07/06/22.
//

import Foundation

//5
protocol LocalisationProvider{
    
    //7
    func fetchGetAirportDataError() -> String
    
    func fetchGetFlightDataError() -> String
    
}

//5
extension LocalisationProvider{
    
    //7
    func fetchGetAirportDataError() -> String {
        return ""
    }
    
    func fetchGetFlightDataError() -> String {
        return ""
    }
    
}

//5
struct LocalisationProviderImpl:LocalisationProvider{
    
    //7
    func fetchGetAirportDataError() -> String {
        return "Failed to Fetch Airport Data"
    }
    
    func fetchGetFlightDataError() -> String {
        return "Failed to Fetch Flight Data"
    }

}
