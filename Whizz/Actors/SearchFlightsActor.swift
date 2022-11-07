//
//  SearchFlightsActor.swift
//  Whizz
//
//  Created by Shaivik Dhavjekar on 04/11/22.
//

import Foundation

//22
// API calls for actor
enum SearchFlightsMessage: AppMessage {
    case GetAirportData(query: String)
    case GetSearchFlightsState(CompletableDeferred<SearchFlightsState>)
}

//18
// API response from actor
enum SearchFlightsState: AppState {
    //19
    case GetAirportDataSuccess(airportData: AirportData)
}

//15
actor SearchFlightsActor{
    
    var searchFlightsService : SearchFlightsService?
    
    var localisationProvider: LocalisationProvider
    
    init(searchFlightsService:SearchFlightsService, localisationProvider:LocalisationProvider){
        self.searchFlightsService = searchFlightsService
        self.localisationProvider = localisationProvider
    }
    
    //17
    var searchFlightsState:SearchFlightsState? = nil
    
    //22
    func run() async -> AppChannel {
        let channel = AppChannelActor()
        
        //Code...
        
        return channel
    }
}
