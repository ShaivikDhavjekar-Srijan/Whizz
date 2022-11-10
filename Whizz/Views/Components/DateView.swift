//
//  DOBView.swift
//  Whizz
//
//  Created by Akarsha Mandrekar on 04/11/22.
//

import SwiftUI

struct DateView:View{
    @State var showPicker: Bool = false
    @Binding var date:Date
    @Binding var dateString:String
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    var body: some View{
        ZStack{
            Button{
                showPicker.toggle()
            } label: {
                Text("")
                    .frame(height: 70.0)
                    .frame(width:UIScreen.main.bounds.width*0.8)
//                    .background(Color.clear)
            }
            VStack(spacing: 7) {
                if dateString == "" {
                    Text("DEPARTURE")
                } else {
                    VStack(spacing: 7) {
                        Text("DEPARTURE").font(.system(.caption))
                        Text(dateString).font(.system(size: 20))
                    }
                }
            }.allowsHitTesting(false)
            
        }.hiddenNavigationBarStyle()
            .frame(width: UIScreen.main.bounds.width*0.8, height: 60.0)
            .sheet(isPresented: $showPicker, onDismiss: {
                dateString = dateFormatter.string(from: date)
            }, content: {
                CusDatePicker(currentDate: $date)
                    .background(.black)
            })
    }
}

struct CusDatePicker: View {
    @Binding var currentDate: Date
    
    var body: some View {
        DatePicker("", selection: $currentDate, displayedComponents: [.date]).labelsHidden().datePickerStyle(GraphicalDatePickerStyle()).background(.black)
        
    }
}

