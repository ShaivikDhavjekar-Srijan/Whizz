//
//  SearchFlightsViewModelTest.swift
//  WhizzTests
//
//  Created by Shaivik Dhavjekar on 08/11/22.
//

import XCTest
@testable import Whizz
import Combine

class SearchFlightsViewModelTest: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    let query = "india"
    let from = "BOM"
    let to = "DEL"
    let departure = "2022-11-08T08"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testItShouldShowQueryEmptyAlertWhenQueryIsEmpty() async throws {
        // Given
        actor TestChannel : AppChannel {
            func send(message: AppMessage) {
                
            }
            
            func read() async -> AppMessage? {
                return nil
            }
            
        }
        
        // When
        let searchFlightsViewModel = SearchFlightsViewModel(appChannel: TestChannel())
        try await searchFlightsViewModel.getAirportData(query: "")
        
        // Then
        // Test what the SearchFlightsUIMessage will be
        let _ = searchFlightsViewModel.$searchFlightsUiMessage.sink { state in
            XCTAssertEqual(state, SearchFlightsUiMessage.ShowQueryIsEmptyAlert)
        }.store(in: &cancellables)
        
    }
    
    func testItShouldShowInvalidQueryAlertWhenQueryIsInvalid() async throws {
        // Given
        actor TestChannel : AppChannel {
            func send(message: AppMessage) {
                
            }
            
            func read() async -> AppMessage? {
                return nil
            }
            
        }
        
        // When
        let searchFlightsViewModel = SearchFlightsViewModel(appChannel: TestChannel())
        try await searchFlightsViewModel.getAirportData(query: " ")
        
        // Then
        // Test what the SearchFlightsUIMessage will be
        let _ = searchFlightsViewModel.$searchFlightsUiMessage.sink { state in
            XCTAssertEqual(state, SearchFlightsUiMessage.ShowInvalidQueryAlert)
        }.store(in: &cancellables)
    }
    
    func testItShouldShowErrorMessageOnFailedGetAirportData() async throws {
        // Given
        actor TestChannel : AppChannel {
            var searchFlightsState: SearchFlightsState? = nil
            
            func send(message: AppMessage) {
                switch(message){
                case SearchFlightsMessage.GetAirportData(query: _):
                    searchFlightsState = .GetAirportDataFailure(error: "Failed to Fetch Airport Data")
                case SearchFlightsMessage.GetSearchFlightsState(let completableDeferred):
                    Task {
                        await completableDeferred.resume(value:searchFlightsState!)
                    }
                default:
                    break
                }
            }
            
            func read() async -> AppMessage? {
                return nil
            }
            
        }
        
        // When
        let searchFlightsViewModel = SearchFlightsViewModel(appChannel: TestChannel())
        try await searchFlightsViewModel.getAirportData(query: self.query)
        
        // Then
        // Test what the SearchFlightsUIMessage will be
        let _ = searchFlightsViewModel.$searchFlightsUiMessage.sink { state in
            XCTAssertEqual(state, SearchFlightsUiMessage.ShowFailedGetAirportDataAlert(error: "Failed to Fetch Airport Data"))
        }.store(in: &cancellables)
    }
    
    func testItShouldShowEmptyFieldAlertWhenFromIsEmpty() async throws{
        // Given
        actor TestChannel : AppChannel {
            func send(message: AppMessage) {
                
            }
            
            func read() async -> AppMessage? {
                return nil
            }
            
        }
        
        // When
        let searchFlightsViewModel = SearchFlightsViewModel(appChannel: TestChannel())
        try await searchFlightsViewModel.getFlightData(from: "", to: self.to, departure: self.departure)
        
        //Then
        let _ = searchFlightsViewModel.$searchFlightsUiMessage.sink { state in
            XCTAssertEqual(state, SearchFlightsUiMessage.ShowFromFieldEmptyAlert)
        }.store(in: &cancellables)
        
        
    }
    
    func testItShouldShowEmptyFieldAlertWhenToIsEmpty() async throws{
        // Given
        actor TestChannel : AppChannel {
            func send(message: AppMessage) {
                
            }
            
            func read() async -> AppMessage? {
                return nil
            }
            
        }
        
        // When
        let searchFlightsViewModel = SearchFlightsViewModel(appChannel: TestChannel())
        try await searchFlightsViewModel.getFlightData(from: self.from, to: "", departure: self.departure)
        
        //Then
        let _ = searchFlightsViewModel.$searchFlightsUiMessage.sink { state in
            XCTAssertEqual(state, SearchFlightsUiMessage.ShowToFieldEmptyAlert)
        }.store(in: &cancellables)
    }
    
    func testItShouldShowToAndDromSimilarAlertWhenToAndFromAreSame() async throws{
        // Given
        actor TestChannel : AppChannel {
            func send(message: AppMessage) {
                
            }
            
            func read() async -> AppMessage? {
                return nil
            }
            
        }
        
        // When
        let searchFlightsViewModel = SearchFlightsViewModel(appChannel: TestChannel())
        try await searchFlightsViewModel.getFlightData(from: "DEL", to: "DEL", departure: self.departure)
        
        //Then
        let _ = searchFlightsViewModel.$searchFlightsUiMessage.sink { state in
            XCTAssertEqual(state, SearchFlightsUiMessage.ShowFromFieldEmptyAlert)
        }.store(in: &cancellables)
        
        
    }
    
    func testItShouldShowEmptyFieldAlertWhenDepartureIsEmpty() async throws{
        // Given
        actor TestChannel : AppChannel {
            func send(message: AppMessage) {
                
            }
            
            func read() async -> AppMessage? {
                return nil
            }
            
        }
        
        // When
        let searchFlightsViewModel = SearchFlightsViewModel(appChannel: TestChannel())
        try await searchFlightsViewModel.getFlightData(from: self.from, to: self.to, departure: "")
        
        //Then
        let _ = searchFlightsViewModel.$searchFlightsUiMessage.sink { state in
            XCTAssertEqual(state, SearchFlightsUiMessage.ShowDepartureFieldEmptyAlert)
        }.store(in: &cancellables)
    }
    
    func testItShouldShowFailedGetFligthDataAlert() async throws{
            
            actor TestChannel : AppChannel {
                var SearchFlightsState:SearchFlightsState? = nil
                
                func send(message: AppMessage) {
                    switch(message){
                    case SearchFlightsMessage.GetFlightData(from: _, to: _, departure: _):
                        SearchFlightsState = .GetFlightDataFailure(error: "Failed to Featch Flight Data")
                    case SearchFlightsMessage.GetSearchFlightsState(let completable):
                        Task{
                            await completable.resume(value: SearchFlightsState!)
                        }
                    default:
                        break
                    }
                }
                
                func read() async -> AppMessage? {
                    return nil
                }
       
            }
            // When
            let searchFlightsViewModel = SearchFlightsViewModel(appChannel: TestChannel())
            try await searchFlightsViewModel.getFlightData(from: from, to: to, departure: departure)
            
            // Then
            // Test what the SearchFlightsUIMessage will be
            let _ = searchFlightsViewModel.$searchFlightsUiMessage.sink { state in
                XCTAssertEqual(state, SearchFlightsUiMessage.ShowFailedGetFligthDataAlert(error: "Failed to Fetch Flight Data"))
            }.store(in: &cancellables)
            
        }


}
