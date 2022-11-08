//
//  GroupBoxStyleC.swift
//  Whizz
//
//  Created by Akarsha Mandrekar on 04/11/22.
//

import Foundation
import SwiftUI

struct GroupBoxStyleCreated: GroupBoxStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 8){
            configuration.label
            configuration.content
        }
        .padding(16)
        .frame(alignment: .leading)
        .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 8))
        .background(Color(UIColor.ComponentColor), in: RoundedRectangle(cornerRadius: 8))
    }
}

extension GroupBoxStyle where Self == GroupBoxStyleCreated{
    static var created: GroupBoxStyleCreated{.init()}
}
