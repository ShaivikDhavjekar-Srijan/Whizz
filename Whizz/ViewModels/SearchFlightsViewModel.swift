//
//  SearchFlightsViewModel.swift
//  Whizz
//
//  Created by Shaivik Dhavjekar on 08/11/22.
//

import Foundation

enum SearchFlightsUiMessage: Equatable {
    case ShowQueryIsEmptyAlert
    case ShowInvalidQueryAlert
    case ShowDataIsEmptyAlert
    case ShowFailedGetAirportDataAlert(error: String)
}

class SearchFlightsViewModel: ObservableObject {
    
    var appChannel:AppChannel
    
    @Published private(set) var searchFlightsUiMessage: SearchFlightsUiMessage?
    
    init(appChannel:AppChannel){
        self.appChannel = appChannel
    }
    
    func getAirportData(query:String) async throws {
        
        if(!query.isValidQuery()) {
            if(query.isEmpty) {
                searchFlightsUiMessage = SearchFlightsUiMessage.ShowQueryIsEmptyAlert
            } else {
                searchFlightsUiMessage = SearchFlightsUiMessage.ShowInvalidQueryAlert
            }
            
            let searchFlightsState = CompletableDeferred<SearchFlightsState>()
            await appChannel.send(message: SearchFlightsMessage.GetAirportData(query: query))
            await appChannel.send(message: SearchFlightsMessage.GetSearchFlightsState(searchFlightsState))
            
            if let result = await searchFlightsState.wait() {
                switch (result) {
                case .GetAirportDataSuccess(airportData: let aiportData):
                    break
                case .GetAirportDataFailure(error: let error):
                    searchFlightsUiMessage = SearchFlightsUiMessage.ShowFailedGetAirportDataAlert(error: error)
                    break
                default: break
                }
            }
        }
    }
}
