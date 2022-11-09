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
    static let API_KEY = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiYjkzOGIxNjFmNTc4Y2NhMmFjM2QyZjJhODRhZDA0ZWEyMjkzMzI5MmJkYmFjMzhkZTdlNGIwZjVjNzdlZWFiZDFhYmExY2I5NjQ3NjAzZjEiLCJpYXQiOjE2Njc5NzI3MjQsIm5iZiI6MTY2Nzk3MjcyNCwiZXhwIjoxNjk5NTA4NzI0LCJzdWIiOiIxNzUxNCIsInNjb3BlcyI6W119.WhlmGsULK9iTZ6TKz1Ov18FYMyaxHyagtAma-nYKpt3YiYWmVqe9RvIOg3HG0W34dUL6zZSE4_yALdKV3HalTA"
    static let QUERY = "query"
    
    static let FROM = "dep_iata"
    static let TO = "arr_iata"
    static let DEPARTURE = "arr_scheduled_time_dep"
    
}

struct DateConstants {
    static let DATE_FORMAT = "dd/MM/yyyy"
    static let TIMESTAMP_FORMAT = "yyyy-MM-dd'T'HH:mm:ss"
}
