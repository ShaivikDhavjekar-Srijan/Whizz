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
                    .background(Color(UIColor.whiteColor))
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
                        .background(Color(UIColor.ComponentColor))
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
                        ForEach(model.airportData!, id: \.name) { airport in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(airport.name!)
                                        .font(.headline)
                                    Text("\(airport.city!), \( airport.country!)")
                                }
                                Text(airport.iataCode!)
                            }
                        }
                    }
                } else {
                    Text("What are you searching for?")
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
