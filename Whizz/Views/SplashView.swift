//
//  SplashView.swift
//  Whizz
//
//  Created by Akarsha Mandrekar on 08/11/22.
//

import SwiftUI

enum AnimationState {
    case compress
    case expand
    case normal
}

struct SplashView: View {
    
    @EnvironmentObject var delegate:AppDelegate
    
    @State private var animationState: AnimationState = .normal
    @State private var done: Bool = false
    
    func calculate() -> Double {
        switch animationState {
            case .compress:
                return 0.2
            case .expand:
            return 28.0
            case .normal:
                return 0.4
        }
    }
    
    var body: some View {
        ZStack {
            if(delegate.isAppChannelAvailable){
                if let channel = delegate.appStream {
                    HomeView(channel: channel)
                        .listStyle(.plain)
                        .scaleEffect(done ? 1: 0.95)
                }
            }
            else{
                Text("Please Wait while the App is Loading.")
            }
            
            VStack {
                Image("Splash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(calculate())
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
                .opacity(done ? 0 : 1)
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.spring()) {
                    animationState = .compress
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.spring()) {
                            animationState = .expand
                            withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 15.0, initialVelocity: 0)) {
                                done = true
                            }
                        }
                    }
                }
                
            }
        }
    }
    
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
