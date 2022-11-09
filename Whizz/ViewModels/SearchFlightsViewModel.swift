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
    case ShowFailedGetAirportDataAlert(error: String)
    
    case ShowFromFeildEmptyAlert
    case ShowToFeildEmptyAlert
    case ShowDepartureFieldEmptyAlert
    case ShowFailedGetFligthDataAlert(error: String)
    
}

class SearchFlightsViewModel: ObservableObject {
    
    var appChannel:AppChannel
    
    @Published private(set) var searchFlightsUiMessage: SearchFlightsUiMessage?
    @Published private(set) var airportData: [Airport]?
    @Published var showAlert: Bool = false
   // @Published private(set) var flightData:
    
    init(appChannel:AppChannel){
        self.appChannel = appChannel
    }
    
    func getAirportData(query:String) async throws {
        
        if(!query.isValidQuery()) {
            if(query.isEmpty) {
                searchFlightsUiMessage = SearchFlightsUiMessage.ShowQueryIsEmptyAlert
                return
            } else {
                searchFlightsUiMessage = SearchFlightsUiMessage.ShowInvalidQueryAlert
                return
            }
        }
        
        let searchFlightsState = CompletableDeferred<SearchFlightsState>()
        await appChannel.send(message: SearchFlightsMessage.GetAirportData(query: query))
        await appChannel.send(message: SearchFlightsMessage.GetSearchFlightsState(searchFlightsState))
        
        if let result = await searchFlightsState.wait() {
            switch (result) {
            case .GetAirportDataSuccess(airportData: let airportData):
                
                await setAirportData(airportResponse: airportData.data)
                
                break
            case .GetAirportDataFailure(error: let error):
                searchFlightsUiMessage = SearchFlightsUiMessage.ShowFailedGetAirportDataAlert(error: error)
                break
            default: break
            }
        }
    }
    
    
    func getFlightData(from: String, to: String, departure: String) async throws{
        if(from.isEmpty) {
            await UpdateSearchFlightsUiMessage(message:.ShowFromFeildEmptyAlert, showAlert: true)
            return
        }
        if(to.isEmpty) {
            await UpdateSearchFlightsUiMessage(message:.ShowToFeildEmptyAlert, showAlert: true)
            return
        }
        if(departure.isEmpty) {
            await UpdateSearchFlightsUiMessage(message:.ShowDepartureFieldEmptyAlert, showAlert: true)
            return
        }
        
        let searchFlightsState = CompletableDeferred<SearchFlightsState>()
        
    }
    
    
    @MainActor private func UpdateSearchFlightsUiMessage(message:SearchFlightsUiMessage, showAlert:Bool){
        self.searchFlightsUiMessage = message
        self.showAlert = showAlert
        
    }
    
    
    @MainActor private func setAirportData(airportResponse: [Airport]?) {
        if let data = airportResponse {
            airportData = data
        }
    }
}
