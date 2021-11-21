//
//  ServiceLayer.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 9/27/21.
//

import Foundation

final class ServiceLayer {
    
    static let shared = ServiceLayer()
    
    private(set) lazy var loginService = BaseLoginService()
    
    private(set) lazy var mockDataService = BaseMockDataService()
}
