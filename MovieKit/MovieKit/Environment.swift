//
//  Secrets.swift
//  MovieKit
//
//  Created by Cameron Slash on 2/28/24.
//

import Foundation

//public class Secrets {
//    public static var API_KEY: String = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
//}
public enum Secrets {
    enum Keys {
        static let apiKey = "API_KEY"
        static let baseUrl = "BASE_URL"
    }
    
    public static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    public static let baseURL: String = {
        guard let baseURLString = Secrets.infoDictionary[Keys.baseUrl] as? String else {
            fatalError("Base URL not set in plist")
        }
        return baseURLString
    }()
    
    public static let apiKey: String = {
        guard let apiKeyString = Secrets.infoDictionary[Keys.apiKey] as? String else {
            fatalError("API Key not set in plist")
        }
        return apiKeyString
    }()
}
