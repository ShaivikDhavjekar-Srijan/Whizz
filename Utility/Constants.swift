//
//  Constants.swift
//  Swiko
//
//  Created by Srijan on 01/06/22.
//

import Foundation

struct ApiConstants{
    static let BASE_URL = "https://swiko-demon.herokuapp.com/api/rest/"
    static let FORCE_UPDATE = "getAppVersion"
    static let SIGN_IN = "signin"
    static let VERIFY_EMAIL = "verifyEmail"
    static let VERIFY_OTP = "verifyUserOtp"
    static let RESET_PASSWORD = "resetPassword"
    static let SIGN_UP = "signup"
    static let FETCH_PROFILE = "getUser"
    static let UPDATE_PROFILE = "editProfile"
    
    // MARK: API KEYS
    static let EMAIL = "email"
    static let PASSWORD = "password"
    static let OTP = "token"
    static let FIRST_NAME = "firstName"
    static let LAST_NAME = "lastName"
    static let DATE_OF_BIRTH = "dob"
    static let GENDER = "gender"
    static let IMAGE_URL = "image_url"
    static let AUTH_TOKEN = "authToken"
}

struct CloudinaryConstants {
    static let CLOUD_NAME = "srijan-swiko"
    static let PRESET_KEY = "cw9yzb1k"
    static let FOLDER_NAME = "Swiko_users"
}

struct GenderConstants {
    static let MALE = "Male"
    static let FEMALE = "Female"
    static let NON_BINARY = "Non-Binary"
}

struct DateConstants {
    static let DATE_FORMAT = "dd/MM/yyyy"
    static let TIMESTAMP_FORMAT = "yyyy-MM-dd'T'HH:mm:ss"
}
