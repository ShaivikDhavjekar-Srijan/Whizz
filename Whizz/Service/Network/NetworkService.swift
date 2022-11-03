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
    case forceUpdate
    case login(param:AnyDict)
    case verifyEmail(param:AnyDict)
    case verifyOtp(param:AnyDict)
    case resetPassword(param:AnyDict)
    case signUp(param:AnyDict)
    case fetchProfile(param: AnyDict)
    case updateProfile(param: AnyDict)
}

extension NetworkAPI {
    
    var path: String  {
        var servicePath = ""
        switch self {
        case.forceUpdate:
            servicePath = ApiConstants.FORCE_UPDATE
        case .login:
            servicePath = ApiConstants.SIGN_IN
        case .verifyEmail:
            servicePath = ApiConstants.VERIFY_EMAIL
        case .verifyOtp :
            servicePath = ApiConstants.VERIFY_OTP
        case .resetPassword :
            servicePath = ApiConstants.RESET_PASSWORD
        case .signUp:
            servicePath = ApiConstants.SIGN_UP
        case .fetchProfile :
            servicePath = ApiConstants.FETCH_PROFILE
        case .updateProfile :
            servicePath = ApiConstants.UPDATE_PROFILE
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
        case .login(let param),
                .verifyEmail(let param),
                .verifyOtp(let param),
                .resetPassword(let param),
                .signUp(let param),
                .fetchProfile(let param),
                .updateProfile(let param):
            allParam = param
        default:
            allParam = [ : ]
        }
        return allParam
    }
    
    var method:HTTPMethod {
        switch self {
        case .login,
                .verifyEmail,
                .verifyOtp,
                .resetPassword,
                .signUp,
                .updateProfile:
            return .post
        default:
            return .get
        }
    }
    
    var encoding:ParameterEncoding {
        switch self {
        case .login,
                .verifyEmail,
                .verifyOtp,
                .resetPassword,
                .signUp,
                .updateProfile:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
}

