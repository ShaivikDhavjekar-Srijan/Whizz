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
    let from = "China"
    let to = "India"
    let departure = "2022-11-15"

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
    
    func testItShouldReturnStateGetFlightDataSuccessOnSuccessfulDataFetch() async throws {
        
        //a
        let testLocalisationProvider = TestLocalisationProvider()
        
        let flightData = GetFlightDataResponse(flightDate: "2022-11-08", flightStatus: "active", departure: DepArr(airport: "Chhatrapati Shivaji International (Sahar International)", timezone: "Asia/Kolkata", iata: "BOM", delay: 14, scheduled: "2022-11-08T08:45:00+00:00", actual: "2022-11-08T08:58:00+00:00"), arrival: DepArr(airport: "Indira Gandhi International", timezone: "Asia/Kolkata", iata: "DEL", delay: nil , scheduled: "2022-11-08T11:00:00+00:00", actual: nil), airline: Airline(name: "Vistara", iata: "UK", icao: "VTI"), flight: Flight(number: "970", iata: "UK970", icao: "VTI970"))
        
        struct TestSearchFlightsService: SearchFlightsService {
            func getFlightData(from: String, to: String, departure: String) async throws -> GetFlightDataResponse? {
                return GetFlightDataResponse(flightDate: "2022-11-08", flightStatus: "active", departure: DepArr(airport: "Chhatrapati Shivaji International (Sahar International)", timezone: "Asia/Kolkata", iata: "BOM", delay: 14, scheduled: "2022-11-08T08:45:00+00:00", actual: "2022-11-08T08:58:00+00:00"), arrival: DepArr(airport: "Indira Gandhi International", timezone: "Asia/Kolkata", iata: "DEL", delay: nil , scheduled: "2022-11-08T11:00:00+00:00", actual: nil), airline: Airline(name: "Vistara", iata: "UK", icao: "VTI"), flight: Flight(number: "970", iata: "UK970", icao: "VTI970"))
            }
            
        }
        
        //Given
        let actor = SearchFlightsActor(searchFlightsService: TestSearchFlightsService(), localisationProvider: testLocalisationProvider)
        
        let channel = await actor.run()
        let searchFlightsState = CompletableDeferred<SearchFlightsState>()
        
        //When
        await withTaskGroup(of: Void.self){ group in
            group.addTask {
                await channel.send(message: SearchFlightsMessage.GetFlightData(from: self.from, to: self.to, departure: self.departure))
            }
            group.addTask {
                await channel.send(message: SearchFlightsMessage.GetSearchFlightsState(searchFlightsState))
            }
        }
        
       
        //Then
        if let result = await searchFlightsState.wait() {
            print(result)
            XCTAssertEqual(result, SearchFlightsState.GetFlightDataSuccess(flightData: [flightData]))
        }
        
    
    }
    
    
    func testItShouldReturnStateGetFlightDataFailureOnUnsuccessfulDataFetch() async throws{

        let testLocalisationProvider = TestLocalisationProvider()
        
        //8
        struct TestSearchFlightsService: SearchFlightsService {
            //14
            func getFlightData(from: String, to: String, departure: String) async throws -> [GetFlightDataResponse]? {
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
                await channel.send(message: SearchFlightsMessage.GetFlightData(from: self.from, to: self.to, departure: self.departure))
            }
            group.addTask {
                await channel.send(message: SearchFlightsMessage.GetSearchFlightsState(searchFlightsState))
            }
        }
        
        //Then
        if let result = await searchFlightsState.wait() {
            print(result)
            XCTAssertEqual(result, SearchFlightsState.GetFlightDataFailure(error: testLocalisationProvider.fetchGetFlightDataError()))
        }

    }
    

}
