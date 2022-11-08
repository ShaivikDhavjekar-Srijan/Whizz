//
//  NetworkService.swift
//  EYAssetManagement
//
//  Created by Kartik on 19/02/21.
//

import Foundation
import Foundation
import Alamofire

typealias AnyDict = [String: Any]
typealias AnyDictString = [String: String]
typealias emptyCompletionHandler = ()->()

var BaseURL: String {
    ApiConstants.BASE_URL
}

enum NetworkAPI {
    case getAiportData(param:AnyDict)
    case getFlightData(param:AnyDict)
}

extension NetworkAPI {
    
    var path: String  {
        var servicePath = ""
        switch self {
        case.getAiportData:
            servicePath = ApiConstants.GET_AIRPORT_DATA
        case.getFlightData:
            servicePath = ApiConstants.GET_FLIGHTS
        }
        return BaseURL + servicePath
    }
    
    var headers: HTTPHeaders? {
        let headersDict = HTTPHeaders()
        return headersDict
    }
    
    var parameters:AnyDict? {
        var allParam : AnyDict = [ : ]
        switch self {
        case .getAiportData(param: let param), .getFlightData(param: let param):
            allParam = param
        default:
            allParam = [ : ]
        }
        return allParam
    }
    
    var method:HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var encoding:ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
}

