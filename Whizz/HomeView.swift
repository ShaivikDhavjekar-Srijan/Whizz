//
//  HomeView.swift
//  Whizz
//
//  Created by Akarsha Mandrekar on 04/11/22.
//

import SwiftUI

struct HomeView: View {
    @State private var origin = ""
    @State private var target = ""
    @State private var DOB = Date()
    @State private var DOBString = ""
    
    var body: some View {
        
        
        ScrollView {
            Spacer().frame(height: 125)
            ZStack{
                Image("home")
                    .resizable()
                    .aspectRatio(contentMode:.fit)
                    .opacity(0.06)
                
                
                VStack(){
                    Spacer().frame(height: 125)
                    Text("Whizz")
                        .fontWeight(.thin)
                        .foregroundColor(Color(UIColor.Blue))
                        .font(.system(size: 80))
                    
                    GroupBox{
                        HStack{
                            TextField("from", text: $origin)
                                .frame(height: 60.0)
                                
                            
                            
                            TextField("Where to?", text: $target)
                                .frame(height: 60.0)
                            
                        }
                        DOBView(date:$DOB,dob:$DOBString)
                            .frame(height:60.0)
                        
                        
                    }label: {
                        Label("Search flight", systemImage: "airplane.arrival")
                    }
                    .groupBoxStyle(.created)
                    
                    
                    Button{
                        
                    } label: {
                        Text("SEARCH")
                            .frame(height: 51)
                            .foregroundColor(.white)
                            .frame(width:UIScreen.main.bounds.width*0.8)
                            .background(Color(UIColor.MidnightBlue))
                            .cornerRadius(8.0)
                    }
                    .padding(.top, 30)
                    Spacer()
                    
                }
                .frame(width:UIScreen.main.bounds.width*0.8)
                
            }
        }
        .ignoresSafeArea()
    }
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
