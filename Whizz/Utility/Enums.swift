//
//  Enums.swift
//  Swiko
//
//  Created by Srijan on 01/06/22.
//

import Foundation

enum ApiResponse<T> {
  case success(value: T)
  case failure(error: Error)
}

enum Screens {
    case Tab(selectedTab: String)
}
