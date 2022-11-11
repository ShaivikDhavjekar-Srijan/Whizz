//
//  DetailView.swift
//  Whizz
//
//  Created by Akarsha Mandrekar on 08/11/22.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        ZStack(alignment: .top){
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
               
                
                Spacer().frame(height: 60)
                Text("Boarding Pass")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                ZStack{
                    Image("BoardingPass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(30)
                    
                    VStack(alignment: .leading) {
                        
                        Label("Flight name", systemImage: "airplane")
                        
                        Spacer()
                        Text("ODS")
                            .font(.system(size: 50))
                            .bold()
                            .foregroundColor(.black)
                        
                        Text("Odessa, Ukraine")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.black)
                        
                        Spacer()
                        Text("CDG")
                            .font(.system(size: 50))
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.black)
                        Text("Paris, France")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.black)
                        
                        
                    }.frame(width:UIScreen.main.bounds.width*0.5, height:UIScreen.main.bounds.width*0.6)
                        .offset(x:-40, y: -95)
                    
                    
                    HStack{
                        VStack{
                            Text("10:30 Am \n 29-08-2022")
                        }
                        
                        
                    }.frame(width:UIScreen.main.bounds.width*0.5, height:UIScreen.main.bounds.width*0.6)
                        .offset(x:-40, y: 255)
                    
                }
            }
            
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

