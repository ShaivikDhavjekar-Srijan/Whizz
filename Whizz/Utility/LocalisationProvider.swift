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
    func getFetchAirportDataError() -> String
    
}

//5
extension LocalisationProvider{
    
    //7
    func getFetchAirportDataError() -> String {
        return ""
    }
    
}

//5
struct LocalisationProviderImpl:LocalisationProvider{
    
    //7
    func getFetchAirportDataError() -> String {
        return "Failed to Fetch Airport Data"
    }

}
