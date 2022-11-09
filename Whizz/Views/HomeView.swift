//
//  HomeView.swift
//  Whizz
//
//  Created by Akarsha Mandrekar on 04/11/22.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject var model:SearchFlightsViewModel
    
    init(channel:AppChannel){
        _model = StateObject(wrappedValue: SearchFlightsViewModel(appChannel: channel))
    }
    
    @State private var from: String = ""
    @State private var to: String = ""
    @State private var DOB = Date()
    @State private var DOBString = ""
    @State var isSearchFromViewShowing: Bool = false
    @State var isSearchToViewShowing: Bool = false
    
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
                                    
                                    Button {
                                        isSearchFromViewShowing.toggle()
                                    } label: {
                                        if from == "" {
                                            Text("FROM")
                                        } else {
                                            Text(from)
                                        }
                                    }
                                    .frame(width: 150, height: 60.0)
                                    .foregroundColor(.black).opacity(0.4)
                                    
//                                    TextField("from", text: $origin)
//                                        .frame(height: 60.0)


                                    Rectangle()
                                        .fill(.black)
                                        .frame(width:1,height:25)
                                        .opacity(0.4)
                                    
                                    Button {
                                        isSearchToViewShowing.toggle()
                                    } label: {
                                        if to == "" {
                                            Text("TO")
                                        } else {
                                            Text(to)
                                        }
                                    }
                                    .frame(width: 150, height: 60.0)
                                    .foregroundColor(.black).opacity(0.4)

//                                    TextField("Where to?", text: $target)
//                                        .frame(height: 60.0)

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
        //Trailing Closures
        .sheet(isPresented: $isSearchFromViewShowing) {
            SearchView(bindingQuery: $from, dismissSearchView: $isSearchFromViewShowing, model: model)
        }
        .sheet(isPresented: $isSearchToViewShowing) {
            SearchView(bindingQuery: $to, dismissSearchView: $isSearchToViewShowing, model: model)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(channel: AppChannelActor())
    }
}
