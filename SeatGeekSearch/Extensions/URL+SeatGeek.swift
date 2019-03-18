//
//  URLComponents+SeatGeek.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/13/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import Foundation

typealias SeatGeekRequest = URL

extension URL {
    
    private static let seatGeekHost = "api.seatgeek.com"
    private static let seatGeekScheme = "https"
    private static let seatGeekPath = "/2/events"
    private static let seatGeekAPIKey = "MTU3Mzk1NDV8MTU1MjQ2Mjg4Mi43NA"
    
    static func seatGeekRequest(query: String) -> SeatGeekRequest {
        var components = URLComponents()
        components.scheme = seatGeekScheme
        components.host = seatGeekHost
        components.path = seatGeekPath
        let clientId = URLQueryItem(name: "client_id", value: seatGeekAPIKey)
        let searchQuery = URLQueryItem(name: "q", value: query)
        components.queryItems = [clientId, searchQuery]
        guard let url = components.url else {
            fatalError("Must return a valid URL")
        }
        return url
    }
    
    func isValidSeatGeekRequest() -> Bool {
        return path == URL.seatGeekPath &&
        host == URL.seatGeekHost &&
        scheme == URL.seatGeekScheme
    }
    
}
