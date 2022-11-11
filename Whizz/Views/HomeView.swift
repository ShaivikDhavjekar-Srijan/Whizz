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
    
    private var statusMessage:String? {
        switch model.searchFlightsUiMessage{
        case .ShowFromFieldEmptyAlert:
            return "Please enter the flight departure location."
        case .ShowToFieldEmptyAlert:
            return "Please enter the flight arrival location."
        case .ShowToAndFromSimilarAlert:
            return "The departure and arrival locations are the same."
        case .ShowDepartureFieldEmptyAlert:
            return "Please enter the flight departure date."
        case .ShowFailedGetFligthDataAlert(error: let error):
            return "\(error)"
        default:
            break
        }
        return ""
    }
    
    @State private var from: Airport = Airport(iataCode: "", name: "", city: "", country: "")
    @State private var to: Airport = Airport(iataCode: "", name: "", city: "", country: "")
    @State private var departure = Date()
    @State private var departureString = ""
    @State var isSearchFromViewShowing: Bool = false
    @State var isSearchToViewShowing: Bool = false
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                
                Color.black.edgesIgnoringSafeArea(.all)
                
                GifImageView("AirplaneGif")
                    .frame(width:geometry.size.width*0.8, height: geometry.size.width*0.59)
                    .allowsHitTesting(false)
                
                VStack{
                    
                    Spacer().frame(height: geometry.size.height*0.235)
                    
                    Text("Whizz")
                        .fontWeight(.thin)
                        .foregroundColor(Color(UIColor.ComponentColor))
                        .font(.system(size: geometry.size.height*0.105))
                    
                    GroupBox{
                        HStack{
                            
                            Button {
                                isSearchFromViewShowing.toggle()
                            } label: {
                                if (from.iataCode == "") {
                                    Text("FROM")
                                } else {
                                    VStack(spacing: 7) {
                                        Text("FROM").font(.system(.caption))
                                        if let city = from.city, let country = from.country {
                                            Text("\(city), \(country)").font(.system(size: 20))
                                        }
                                        
                                    }
                                }
                            }
                            .frame(width: 150, height:70.0)
                            .foregroundColor(.black).opacity(0.4)
                            
                            Rectangle()
                                .fill(.black)
                                .frame(width:1,height:30)
                                .opacity(0.4)
                            
                            Button {
                                isSearchToViewShowing.toggle()
                            } label: {
                                if (to.iataCode == "") {
                                    Text("TO")
                                } else {
                                    VStack(spacing: 7) {
                                        Text("TO").font(.system(.caption))
                                        Text("\(to.city!), \(to.country!)").font(.system(size: 20))
                                    }
                                }
                            }
                            .frame(width: 150, height: 70.0)
                            .foregroundColor(.black).opacity(0.4)
                            
                        }
                        DateView(date:$departure,dateString:$departureString)
                            .frame(height:70.0)
                            .foregroundColor(.black).opacity(0.4)
                        
                        
                    } label: {
                        Label("Search flight", systemImage: "airplane.arrival")
                            .opacity(0.6)
                    }
                    .groupBoxStyle(.created)
                    .frame(width:geometry.size.width*0.9)
                                        
                    Button{
                        Task{
                            try await model.getFlightData(from: self.from, to: self.to, departure: self.departureString)
                        }
                    } label: {
                        Text("SEARCH")
                            .frame(height: geometry.size.height*0.066)
                            .foregroundColor(.black)
                            .frame(width:geometry.size.width*0.8)
                            .background(Color(UIColor.ComponentColor))
                            .cornerRadius(8.0)
                    }
                    .padding(.top, 30)
                    
                }
                .frame(width:geometry.size.width*0.8)
                
            }
            //Trailing Closures
            .sheet(isPresented: $isSearchFromViewShowing) {
                SearchView(result: $from, dismissSearchView: $isSearchFromViewShowing, model: model)
            }
            .sheet(isPresented: $isSearchToViewShowing) {
                SearchView(result: $to, dismissSearchView: $isSearchToViewShowing, model: model)
            }
            .alert(isPresented: $model.showAlert) {
                return Alert(title: Text("Whizz"), message: Text(self.statusMessage ?? ""), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(channel: AppChannelActor())
    }
}
