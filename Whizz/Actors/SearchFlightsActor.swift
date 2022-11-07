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
    case GetFlightData(from: String, to: String, departure: String)
    case GetSearchFlightsState(CompletableDeferred<SearchFlightsState>)
}

//18
// API response from actor
enum SearchFlightsState: AppState {
    //19
    case GetAirportDataSuccess(airportData: GetAirportDataResponse)
    case GetAirportDataFailure(error: String)
    case GetFlightDataSuccess(flightData: [GetFlightDataResponse])
    
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
    func run() async -> AppChannel{
        let channel = AppChannelActor()
        Task{
            guard !Task.isCancelled else {
                return
            }
            while let message = await channel.read() {
                guard !Task.isCancelled else {
                    break
                }
                switch message {
                case SearchFlightsMessage.GetAirportData(query: let query):
                    searchFlightsState = await getAirportData(searchFlightsService:searchFlightsService,
                                                        localisationProvider:localisationProvider,
                                                        query:query)
                
                case SearchFlightsMessage.GetSearchFlightsState(let completableDeferred):
                    if let state = searchFlightsState {
                        await completableDeferred.resume(value:state)
                    }
                    
                default:
                    break
                }
                guard !Task.isCancelled else {
                    break
                }
            }
        }
        return channel
    }
    
    func getAirportData(searchFlightsService:SearchFlightsService?, localisationProvider:LocalisationProvider, query:String) async -> SearchFlightsState? {

        if let service = searchFlightsService{
            do {
                if let result = try await service.getAirportData(query: query) {
                    return SearchFlightsState.GetAirportDataSuccess(airportData: result)
                }
            } catch {
                return SearchFlightsState.GetAirportDataFailure(error: localisationProvider.fetchGetAirportDataError())
            }
        }
        return SearchFlightsState.GetAirportDataFailure(error: localisationProvider.fetchGetAirportDataError())
    }
}
