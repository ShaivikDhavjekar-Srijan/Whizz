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
    func getFetchAirportDataError() -> String {
        return "Failed to Fetch Airport Data"
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

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //1
    func testItShouldReturnStateGetAirportDataSuccessOnSuccessfulDataFetch() async throws {
        
        //3
        let testLocalisationProvider = TestLocalisationProvider()
        
        //24
        let airportData = AirportData(success: true, data: [Airport(iataCode: "DEL", name: "New Delhi", city: "New Delhi", country: "India")])
        
        //8
        struct TestSearchFlightsService: SearchFlightsService {
            //14
            func getAirportData(query: String) async throws -> GetAirportDataResponse? {
                return nil
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
        
    }

}
