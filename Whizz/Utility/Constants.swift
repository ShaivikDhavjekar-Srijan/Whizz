//
//  Constants.swift
//  Swiko
//
//  Created by Srijan on 01/06/22.
//

import Foundation

struct ApiConstants{
    static let BASE_URL = "https://app.goflightlabs.com/"
    static let GET_AIRPORT_DATA = "get-airport-data"
    static let GET_FLIGHTS = "flights"
    
    // MARK: API KEYS
    static let ACCESS_KEY = "access_key"
    static let API_KEY = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiYzVhZTFkYzYxMGZiOTE5NmYzYzJlMmY3ZmZlZDY3Mzc0NGM4NTE4ZGVkYzkxMjUxOTVmYzk5MjhhMGY2NWU0NWY0NGVkZDg4ZmIzNGQ4YjUiLCJpYXQiOjE2Njc4ODQxNTMsIm5iZiI6MTY2Nzg4NDE1MywiZXhwIjoxNjk5NDIwMTUzLCJzdWIiOiIxNzM4NCIsInNjb3BlcyI6W119.fsOaBJntefXXHEmQavDkwPyQpNLd67b1CMRZNwSNgTzVQ30tJxaw9i4aqZ94X6whP46rIAQfB8IFu2vQj_bXAg"
    static let QUERY = "query"
    
    static let FROM = "dep_iata"
    static let TO = "arr_iata"
    static let DEPARTURE = "arr_scheduled_time_dep"
    
}

struct DateConstants {
    static let DATE_FORMAT = "dd/MM/yyyy"
    static let TIMESTAMP_FORMAT = "yyyy-MM-dd'T'HH:mm:ss"
}
