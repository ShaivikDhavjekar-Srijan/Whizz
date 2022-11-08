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
    static let API_KEY = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI0IiwianRpIjoiZjIzMzM1YWRhMmZiZGI1NmM4ZWM5MGZmNzBhMTEyZTI1MzE2YWUyMWViMzY0MDAxYjZmYjIwYzY1MjBmMzc4MjI4M2QwMGUzMmUyZDBhMjciLCJpYXQiOjE2Njc0NjQ3MTEsIm5iZiI6MTY2NzQ2NDcxMSwiZXhwIjoxNjk5MDAwNzExLCJzdWIiOiIxNjg5NCIsInNjb3BlcyI6W119.esAMjiK1Ko8K2XtnHqHOS38gds42NeU-ujZfdG9ePs5TTaM2Z07FVF-94bnnxO8ViRDSpzy2MaX7Lb_a9uu1MA"
    static let QUERY = "query"
    
    static let FROM = "dep_iata"
    static let TO = "arr_iata"
    static let DEPARTURE = "arr_scheduled_time_dep"
    
}

struct DateConstants {
    static let DATE_FORMAT = "dd/MM/yyyy"
    static let TIMESTAMP_FORMAT = "yyyy-MM-dd'T'HH:mm:ss"
}
