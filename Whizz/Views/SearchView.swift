//
//  SearchView.swift
//  Whizz
//
//  Created by Shaivik Dhavjekar on 08/11/22.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var model:SearchFlightsViewModel
    
    init(channel:AppChannel){
        _model = StateObject(wrappedValue: SearchFlightsViewModel(appChannel: channel))
    }
    
    @State private var query = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search...",text:$query)
                    .frame(width: UIScreen.main.bounds.width*0.7, height: 30)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color(.white))
                    .cornerRadius(17)
                
                Button {
                    UIApplication.shared.hideKeyboard()
                    Task{
                        try await model.getAirportData(query:self.query)
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width:30, height:30)
                        .padding(10)
                        .background(Color("ComponentColor"))
                        .cornerRadius(17)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.15)
            .background(.black)
            
            ZStack {
                if model.airportData != nil {
                    if model.airportData == [] {
                        Text("Sorry! No result found :(")
                    } else {
                        VStack(spacing: 10) {
                            ForEach(model.airportData!, id: \.name) { airport in
                                if (airport.city != nil) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(airport.name!)
                                                .font(.headline)
                                            Text("\(airport.city!), \( airport.country!)")
                                                .font(.subheadline)
                                        }
                                        Spacer()
                                        Text(airport.iataCode!)
                                            .fontWeight(.bold)
                                            .font(.system(size: 32))
                                    }
                                    .frame(width: UIScreen.main.bounds.width*0.8, height: 90)
                                    .padding(.horizontal, 20)
                                    .background(.thickMaterial)
                                    .background(Color("ComponentColor"))
                                    .cornerRadius(17)
                                    .onTapGesture {
                                        query = airport.iataCode ?? "Failed"
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                } else {
                    if model.searchFlightsUiMessage == .ShowQueryIsEmptyAlert {
                        Text("The Query is Empty")
                    } else if model.searchFlightsUiMessage == .ShowInvalidQueryAlert {
                        Text("Invalid Query")
                    } else {
                        Text("What are you searching for?")
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.85)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(channel: AppChannelActor())
    }
}
