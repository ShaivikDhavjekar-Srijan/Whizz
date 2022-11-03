//
//  AppChannel.swift
//  Swiko
//
//  Created by Kartik on 01/06/22.
//

import Foundation

protocol AppMessage{}
protocol AppState:AppMessage,Equatable{}
protocol AppChannel:Actor{
    func send(message:AppMessage)
    func read() async -> AppMessage?
}

actor AppChannelActor:AppChannel{

    var messages:[AppMessage] = []
    var continuations:[CheckedContinuation<AppMessage, Never>] = []
    
    func send(message:AppMessage){
        if (!continuations.isEmpty){
            continuations.forEach { continuation in
                continuation.resume(returning: message)
            }
            continuations.removeAll()
            return
        }
        messages.append(message)
    }
    
    func read() async -> AppMessage?{
        if (!messages.isEmpty){
            let message = messages.removeFirst()
            return message
        }
        return await withCheckedContinuation { continuation in
            continuations.append(continuation)
        }
    }
    
}
