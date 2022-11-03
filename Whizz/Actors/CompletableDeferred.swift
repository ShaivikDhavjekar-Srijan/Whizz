//
//  CompletableDeferred.swift
//  Swiko
//
//  Created by Kartik on 01/06/22.
//

import Foundation

actor CompletableDeferred<T>{
    
    var continuation:CheckedContinuation<T, Never>? = nil
    
    var completed:Bool = false
    
    var returnValue:T? = nil
    
    func wait() async -> T? {
        guard !completed else {
            return returnValue
        }
        return await withCheckedContinuation { cont in
            continuation = cont
        }
    }
    
    func resume(value:T){
        returnValue = value
        completed = true
        if (continuation != nil){
            continuation?.resume(returning: value)
        }
    }
}
