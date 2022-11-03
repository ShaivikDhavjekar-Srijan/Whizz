//
//  LocalisationProvider.swift
//  Swiko
//
//  Created by Srijan on 07/06/22.
//

import Foundation

protocol LocalisationProvider{
    func getSignInError() -> String
    func getOtpVerificationError() -> String
    func getSignupError() -> String
    func getFetchProfileError() -> String
    func getUpdateProfileSuccess() -> String
    func getUpdateProfileFailure() -> String
}

extension LocalisationProvider{
    func getSignInError() -> String {
        return ""
    }
    func getOtpVerificationError() -> String {
        return ""
    }
    func getSignUpError() -> String {
        return ""
    }
    func getFetchProfileError() -> String {
        return ""
    }
    func getUpdateProfileSuccess() -> String {
        return ""
    }
    func getUpdateProfileFailure() -> String {
        return ""
    }
    
}

struct LocalisationProviderImpl:LocalisationProvider{
   
    func getSignInError() -> String {
        return "Sign in failed"
    }
    func getOtpVerificationError() -> String {
        return "OTP verification failed"
    }
    func getSignupError() -> String {
        return "Sign up failed"
    }
    func getFetchProfileError() -> String {
        return "Profile fetch failed"
    }
    func getUpdateProfileSuccess() -> String {
        return "Profile has been updated successfully"
    }
    func getUpdateProfileFailure() -> String {
        return "Profile update failed"
    }
}
