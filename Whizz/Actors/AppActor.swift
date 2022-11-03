//
//  AppActor.swift
//  Swiko
//
//  Created by Srijan on 02/06/22.
//

import Foundation

actor AppActor {
    
    // MARK:- Services
//    private let appVersionService = AppVersionServiceImpl(networkManager: NetworkManager.shared)
//    private let userService = UserServiceImpl(networkManager: NetworkManager.shared)
//    private let forgotPasswordService = ForgotPasswordServiceImpl(networkManager: NetworkManager.shared)
    
    // MARK:- Providers
    private let localisationProvider = LocalisationProviderImpl()
    
    func run() async -> AppChannel{
        
        let channel = AppChannelActor()
        
    
        // MARK:- Force Update
//        let forceUpdateActor = ForceUpdateActor(appVersionService: appVersionService)
//        let forceUpdateActorChannel = await forceUpdateActor.run()
//
//        //MARK:- User
//        let userActor = UserActor(userService: userService, localisationProvider: localisationProvider)
//        let userActorChannel = await userActor.run()
//
//        //MARK:- ForgotPassword
//        let forgotPasswordActor = ForgotPasswordActor(forgotPasswordService: forgotPasswordService,localisationProvider: localisationProvider)
//        let forgotPasswordActorChannel = await forgotPasswordActor.run()
//
//
//        let navigationActor = NavigationActor()
//        let navigationActorChannel = await navigationActor.run()
        
        //Keep On Adding Actors Above
        
        Task{
            guard !Task.isCancelled else {
                return
            }
            while let message = await channel.read() {
                guard !Task.isCancelled else {
                    break
                }
                Task {
//                    await navigationActorChannel.send(message: message)
//                    await forceUpdateActorChannel.send(message: message)
//                    await userActorChannel.send(message: message)
//                    await forgotPasswordActorChannel.send(message: message)
                }
                guard !Task.isCancelled else {
                    break
                }
            }
        }
        return channel
        
        
    }
    
}
