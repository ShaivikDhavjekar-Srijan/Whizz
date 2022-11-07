//
//  SearchFlightsActorTest.swift
//  WhizzTests
//
//  Created by Shaivik Dhavjekar on 04/11/22.
//

import XCTest
@testable import Whizz

//4
struct TestLocalisationProvider: LocalisationProvider {
    //6
    func fetchGetAirportDataError() -> String {
        return "Failed to Fetch Airport Data"
    }
    
    func fetchGetFlightDataError() -> String {
        return "Failed to Fetch Flight Data"
    }
}

class SearchFlightsActorTest: XCTestCase {
    
    let query = "India"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //1
    func testItShouldReturnStateGetAirportDataSuccessOnSuccessfulDataFetch() async throws {
        
        //3
        let testLocalisationProvider = TestLocalisationProvider()
        
        //24
        let airportData = GetAirportDataResponse(success: true, data: [Airport(iataCode: "DEL", name: "New Delhi", city: "New Delhi", country: "India")])
        
        //8
        struct TestSearchFlightsService: SearchFlightsService {
            //14
            func getAirportData(query: String) async throws -> GetAirportDataResponse? {
                return GetAirportDataResponse(success: true, data: [Airport(iataCode: "DEL", name: "New Delhi", city: "New Delhi", country: "India")])
            }
        }
        
        //16
        //Given
        let actor = SearchFlightsActor(searchFlightsService: TestSearchFlightsService(), localisationProvider: testLocalisationProvider)
        //21
        let channel = await actor.run()
        let searchFlightsState = CompletableDeferred<SearchFlightsState>()
        
        //When
        await withTaskGroup(of: Void.self){ group in
            group.addTask {
                await channel.send(message: SearchFlightsMessage.GetAirportData(query: self.query))
            }
            group.addTask {
                await channel.send(message: SearchFlightsMessage.GetSearchFlightsState(searchFlightsState))
            }
        }
        
        //23
        //Then
        if let result = await searchFlightsState.wait() {
            print(result)
            XCTAssertEqual(result, SearchFlightsState.GetAirportDataSuccess(airportData: airportData))
        }
    }
    
    //2
    func testItShouldReturnStateGetAirportDataFailureOnUnsuccessfulDataFetch() async throws {
        
        let testLocalisationProvider = TestLocalisationProvider()
        
        //8
        struct TestSearchFlightsService: SearchFlightsService {
            //14
            func getAirportData(query: String) async throws -> GetAirportDataResponse? {
                return nil
            }
        }

        //Given
        let actor = SearchFlightsActor(searchFlightsService: TestSearchFlightsService(), localisationProvider: testLocalisationProvider)
        let channel = await actor.run()
        let searchFlightsState = CompletableDeferred<SearchFlightsState>()
        
        //When
        await withTaskGroup(of: Void.self){ group in
            group.addTask {
                await channel.send(message: SearchFlightsMessage.GetAirportData(query: self.query))
            }
            group.addTask {
                await channel.send(message: SearchFlightsMessage.GetSearchFlightsState(searchFlightsState))
            }
        }
        
        //Then
        if let result = await searchFlightsState.wait() {
            print(result)
            XCTAssertEqual(result, SearchFlightsState.GetAirportDataFailure(error: testLocalisationProvider.fetchGetAirportDataError()))
        }
    }

}
