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
    case ShowDepartureFieldEmptyAlert
    case ShowFailedGetFligthDataAlert(error: String)
    
}

class SearchFlightsViewModel: ObservableObject {
    
    var appChannel:AppChannel
    
    @Published private(set) var searchFlightsUiMessage: SearchFlightsUiMessage?
    @Published var showAlert: Bool = false
    @Published private (set) var isAirportDataLoading: Bool = false
    @Published private (set) var isFlightDataLoading: Bool = false
    
    @Published private(set) var airportData: [Airport]?
//    @Published private(set) var flightData: Airline?
    
   // @Published private(set) var flightData:
    
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
        await updateAirportDataLoadingStatus(isAirportDataLoading: true)
        await appChannel.send(message: SearchFlightsMessage.GetAirportData(query: query))
        await appChannel.send(message: SearchFlightsMessage.GetSearchFlightsState(searchFlightsState))
        
        if let result = await searchFlightsState.wait() {
            switch (result) {
            case .GetAirportDataSuccess(airportData: let airportData):
                await setAirportData(airportResponse: airportData.data)
                await updateAirportDataLoadingStatus(isAirportDataLoading: false)
                break
            case .GetAirportDataFailure(error: let error):
                await updateSearchFlightsUiMessage(message:.ShowFailedGetAirportDataAlert(error: error), showAlert: true)
                break
            default: break
            }
        }
    }
    
    
    func getFlightData(from: String, to: String, departure: String) async throws{
        if(from.isEmpty) {
            await updateSearchFlightsUiMessage(message:.ShowFromFieldEmptyAlert, showAlert: true)
            return
        }
        if(to.isEmpty) {
            await updateSearchFlightsUiMessage(message:.ShowToFieldEmptyAlert, showAlert: true)
            return
        }
        if(departure.isEmpty) {
            await updateSearchFlightsUiMessage(message:.ShowDepartureFieldEmptyAlert, showAlert: true)
            return
        }
        await updateFlightDataLoadingStatus(isFlightDataLoading:true)
        
        
        
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
        isAirportDataLoading = false
        airportData = nil
    }
    
    @MainActor private func setAirportData(airportResponse: [Airport]?) {
        if let data = airportResponse {
            airportData = data
        }
    }
    
    @MainActor private func updateSearchFlightsUiMessage(message:SearchFlightsUiMessage, showAlert:Bool){
        self.searchFlightsUiMessage = message
        updateAirportDataLoadingStatus(isAirportDataLoading: false)
        updateFlightDataLoadingStatus(isFlightDataLoading: false)
        self.showAlert = showAlert
    }
    
    @MainActor private func updateAirportDataLoadingStatus(isAirportDataLoading:Bool){
        self.isAirportDataLoading = isAirportDataLoading
    }
    
    @MainActor private func updateFlightDataLoadingStatus(isFlightDataLoading:Bool){
        self.isFlightDataLoading = isFlightDataLoading
    }
    
//    func clearFlightData() {
//        flightData = nil
//    }
//    
//    @MainActor private func setFlightData(FlightResponse: Airline?) {
//        if let data = FlightResponse {
//            flightData = data
//        }
//    }
//    
    
}

