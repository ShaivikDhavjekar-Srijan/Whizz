//
//  BookFlightView.swift
//  Whizz
//
//  Created by Akarsha Mandrekar on 11/11/22.
//

import SwiftUI

let backgroundGradient = LinearGradient(
    gradient: Gradient(colors: [Color.orange, Color.white]),
    startPoint: .topLeading, endPoint: .center)


struct BookFlightView: View {
    var body: some View {
        GeometryReader { geometry in
        ZStack(alignment: .topLeading) {
                   backgroundGradient
                       .ignoresSafeArea()
            
            HStack {
                VStack(alignment: .leading) {
                    
                           Text("Book Your")
                               .font(.largeTitle)
                               .bold()
                               .foregroundColor(.black)
                            Text("Next Flight").font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                }.frame(width:geometry.size.width*0.5)
                
                Image("Flight")
                    .frame(width:geometry.size.width*0.45, height: geometry.size.width*0.2)
                    .opacity(0.6)
            }
        
               }
               .accentColor(Color.black)
            
        }
    }
}

struct BookFlightView_Previews: PreviewProvider {
    static var previews: some View {
        BookFlightView()
    }
}
