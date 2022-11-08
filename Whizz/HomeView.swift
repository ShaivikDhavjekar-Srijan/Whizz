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
        
   
        
        
        ZStack(alignment: .top) {
            
            
                Color.black.edgesIgnoringSafeArea(.all)
            
            GifImageView("AirplaneGif")
                .frame(width:UIScreen.main.bounds.width*0.8, height: 233)
            
            
            VStack{
               
                Spacer().frame(height: 180)
                            Text("Whizz")
                                .fontWeight(.thin)
                                .foregroundColor(Color(UIColor.ComponentColor))
                                .font(.system(size: 80))

                            GroupBox{
                                HStack{
                                    
                                    TextField("from", text: $origin)
                                        .frame(height: 60.0)


                                    Rectangle()
                                        .fill(.black)
                                        .frame(width:1,height:25)
                                        .opacity(0.4)

                                    TextField("Where to?", text: $target)
                                        .frame(height: 60.0)

                                }
                                DOBView(date:$DOB,dob:$DOBString)
                                    .frame(height:60.0)
    

                            }label: {
                                Label("Search flight", systemImage: "airplane.arrival")
                                    .opacity(0.6)
                            }
                            .groupBoxStyle(.created)

        //                    Spacer().frame(height: 20)

                            Button{

                            } label: {
                                Text("SEARCH")
                                    .frame(height: 51)
                                    .foregroundColor(.black)
                                    .frame(width:UIScreen.main.bounds.width*0.8)
                                    .background(Color(UIColor.ComponentColor))
                                    .cornerRadius(8.0)
                            }
                            .padding(.top, 30)

            }
            .frame(width:UIScreen.main.bounds.width*0.8)
            
            
            
        }
        
        
        
 
    }
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
