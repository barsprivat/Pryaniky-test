//
//  APIEndPoint.swift
//  TestPryaniky
//
//  Created by Александр Рублев on 02.07.2021.
//

import Moya


enum APIEndPoint {
    case getInformationList
}

struct TargetProvider: TargetType {
    
    var type: APIEndPoint
    private var defaults: UserDefaults
    
    init(with type: APIEndPoint) {
        self.type = type
        defaults = .standard
    }
    
    public mutating func handle(for type: APIEndPoint) {
        self.type = type
    }
}

extension TargetProvider {
    var baseHeaders: [String: String]? {
        return nil
    }
    var headers: [String: String]? {
        switch type {
        case .getInformationList:
            return ["Content-Type": "application/json"]
        }
    }
    var baseURL: URL {
        return URL(string: "https://pryaniky.com/")!
    }
    
    var path: String {
        switch type {
        case .getInformationList:
            return "static/json/sample.json"
        }
    }
    
    var method: Moya.Method {
        switch type {
        case .getInformationList:
            return .get
        }
    }
  
    var parameters: [String: Any]? {
        switch type {
        case .getInformationList:
            return nil
        }
    }
    
    var task: Task {
        switch type {
        case .getInformationList:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}
