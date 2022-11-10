//
//  DetailView.swift
//  Whizz
//
//  Created by Akarsha Mandrekar on 08/11/22.
//

import SwiftUI
import AVFoundation

let backgroundGradient = LinearGradient(
    gradient: Gradient(colors: [Color(UIColor.ComponentColor), Color.black]),
    startPoint: .top, endPoint: .bottom)


struct DetailView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
//                   backgroundGradient
//                       .ignoresSafeArea()
            VStack(alignment: .leading) {
                       Text("Boarding Pass")
                           .font(.largeTitle)
                           .bold()
                           .foregroundColor(.black)
                       Button("Download Ticket") {

                       }
                   }
               }
               .accentColor(Color.black)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

