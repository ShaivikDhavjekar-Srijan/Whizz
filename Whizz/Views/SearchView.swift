//
//  SearchView.swift
//  Whizz
//
//  Created by Shaivik Dhavjekar on 08/11/22.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var bindingQuery: String
    @Binding var dismissSearchView: Bool
    @ObservedObject var model:SearchFlightsViewModel
    
    private var statusMessage:String? {
        switch model.searchFlightsUiMessage{
        case .ShowQueryIsEmptyAlert:
            return "Please enter a query"
        case .ShowInvalidQueryAlert:
            return "Please enter a valid query"
        case .ShowFailedGetAirportDataAlert(error: let error):
            return "\(error)"
        default:
            break
        }
        return ""
    }
    
    @FocusState private var isFocused: Bool
    @State private var query = ""
    
    var body: some View {
        GeometryReader{ geometry in
            VStack {
                HStack {
                    TextField("Search...",text:$query)
                        .frame(width: geometry.size.width*0.7, height: 30)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color(.white))
                        .cornerRadius(17)
                        .focused($isFocused)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.isFocused = true
                            }
                        }
                    
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
                .frame(width: geometry.size.width, height: geometry.size.height*0.15)
                .background(.black)
                
                ZStack {
                    if model.isAirportDataLoading {
                        ProgressView()
                            .scaleEffect(1.5, anchor: .center)
                    } else {
                        if model.airportData != nil {
                            if model.airportData == [] {
                                Text("Sorry! No results found :(")
                                    .opacity(0.4)
                                    .font(.system(size: 25))
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
                                            .frame(width: geometry.size.width*0.8, height: 90)
                                            .padding(.horizontal, 20)
                                            .background(.thickMaterial)
                                            .background(Color("ComponentColor"))
                                            .cornerRadius(17)
                                            .onTapGesture {
                                                bindingQuery = airport.city ?? "Failed"
                                                dismissSearchView = false
                                            }
                                        }
                                    }
                                    Spacer()
                                }
                            }
                        } else {
                            Text("What are you searching for?")
                                .opacity(0.4)
                                .font(.system(size: 25))
                        }
                    }
                }
                .frame(width: geometry.size.width, height:geometry.size.height*0.85)
            }
            //Trailing Closures
            .onDisappear(){
                model.clearSearchData()
            }
            .alert(isPresented: $model.showAlert) {
                return Alert(title: Text("Whizz"), message: Text(self.statusMessage ?? ""), dismissButton: .default(Text("OK")))
            }
        }
        
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
