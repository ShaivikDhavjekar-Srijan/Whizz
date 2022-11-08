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

}