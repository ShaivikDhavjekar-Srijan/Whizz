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
    
    case ShowFromFieldEmptyAlert
    case ShowToFieldEmptyAlert
    case ShowToAndFromSimilarAlert
    case ShowDepartureFieldEmptyAlert
    case ShowFailedGetFligthDataAlert(error: String)
    
}

class SearchFlightsViewModel: ObservableObject {
    
    var appChannel:AppChannel
    
    @Published private(set) var searchFlightsUiMessage: SearchFlightsUiMessage?
    @Published var showAlert: Bool = false
    @Published private (set) var isLoading: Bool = false
    
    @Published private(set) var airportData: [Airport]?
    @Published private(set) var flightSearchModel: FlightSearchModel!
    
    init(appChannel:AppChannel){
        self.appChannel = appChannel
    }
    
    func getAirportData(query:String) async throws {
        
        if(!query.isValidQuery()) {
            if(query.isEmpty) {
                await updateSearchFlightsUiMessage(message:.ShowQueryIsEmptyAlert, showAlert: true)
                return
            } else {
                await updateSearchFlightsUiMessage(message:.ShowInvalidQueryAlert, showAlert: true)
                return
            }
        }
        
        let searchFlightsState = CompletableDeferred<SearchFlightsState>()
        await updateLoadingStatus(isLoading: true)
        await appChannel.send(message: SearchFlightsMessage.GetAirportData(query: query))
        await appChannel.send(message: SearchFlightsMessage.GetSearchFlightsState(searchFlightsState))
        
        if let result = await searchFlightsState.wait() {
            switch (result) {
            case .GetAirportDataSuccess(airportData: let airportData):
                await setAirportData(airportResponse: airportData.data)
                await updateLoadingStatus(isLoading: false)
                break
            case .GetAirportDataFailure(error: let error):
                await updateSearchFlightsUiMessage(message:.ShowFailedGetAirportDataAlert(error: error), showAlert: true)
                break
            default: break
            }
        }
    }
    
    
    func getFlightData(from: Airport, to: Airport, departure: String) async throws {
        guard let fromIata = from.iataCode, !fromIata.isEmpty else {
            await updateSearchFlightsUiMessage(message:.ShowFromFieldEmptyAlert, showAlert: true)
            return
        }
        
        guard let toIata = to.iataCode, !toIata.isEmpty else {
            await updateSearchFlightsUiMessage(message:.ShowToFieldEmptyAlert, showAlert: true)
            return
        }

        if fromIata == toIata {
            await updateSearchFlightsUiMessage(message:.ShowToAndFromSimilarAlert, showAlert: true)
            return
        }
        
        if(departure.isEmpty) {
            await updateSearchFlightsUiMessage(message:.ShowDepartureFieldEmptyAlert, showAlert: true)
            return
        }
        
        flightSearchModel = FlightSearchModel(from: from, to: to, departure: departure)
        
        
        
//        let searchFlightsState = CompletableDeferred<SearchFlightsState>()
//        await appChannel.send(message: SearchFlightsMessage.GetFlightData(from: from, to: to, departure: departure))
//        await appChannel.send(message: SearchFlightsMessage.GetSearchFlightsState(searchFlightsState))
//
//        if let result = await searchFlightsState.wait() {
//            switch (result) {
//            case .GetFlightDataSuccess(flightData: let flightData):
//
//                await setFlightData(FlightResponse: flightData.airline)
//
//                break
//            case .GetAirportDataFailure(error: let error):
//                searchFlightsUiMessage = SearchFlightsUiMessage.ShowFailedGetAirportDataAlert(error: error)
//                break
//            default: break
//            }
//        }
        
    }
    
    func clearSearchData() {
        searchFlightsUiMessage = nil
        isLoading = false
        airportData = nil
    }
    
    @MainActor private func setAirportData(airportResponse: [Airport]?) {
        if let data = airportResponse {
            airportData = data
        }
    }
    
    @MainActor private func updateSearchFlightsUiMessage(message:SearchFlightsUiMessage, showAlert:Bool){
        self.searchFlightsUiMessage = message
        updateLoadingStatus(isLoading: false)
        self.showAlert = showAlert
    }
    
    @MainActor private func updateLoadingStatus(isLoading:Bool){
        self.isLoading = isLoading
    }
    
}

