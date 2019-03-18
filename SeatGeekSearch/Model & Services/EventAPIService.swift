//
//  TicketAPIService.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/13/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import Foundation
import PromiseKit

// MARK: JSON Model

private struct SeatGeekResponse: Codable {
    let events: [EventResponse]
}

private struct EventResponse: Codable {
    let id: Int
    let title: String
    let datetime_local: String
    let venue: VenueResponse
    let performers: [PerformersResponse]
}

private struct PerformersResponse: Codable {
    let image: String?
}

private struct VenueResponse: Codable {
    let display_location: String
}

private extension EventResponse {
    func toEvent() -> Event {
        guard let date = datetime_local.toDate() else {
            fatalError("Display Location must be converted successfully to date")
        }
        return SeatGeekEvent(id: String(id),
                             locationName: venue.display_location,
                             title: title,
                             date: date,
                             imageURL: performers.first?.image.flatMap( URL.init ))
    }
}


// MARK: Error

enum EventAPIError: Error {
    case searchFailure
}

// MARK: API

struct EventAPIService { //TODO: add protocol interface
    
    let url: SeatGeekRequest
    
    // @REQUIRE:  must be a valid SeatGeek API URL
    init(url: SeatGeekRequest) {
        guard url.isValidSeatGeekRequest() else {
            fatalError("valid SeatGeek URL Required")
        }
        self.url = url
    }
    
    func search() -> Promise<[Event]?> {
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadRevalidatingCacheData, timeoutInterval: 10)
        return firstly {
            URLSession.shared.dataTask(.promise, with: request)
        }.compactMap {
            try JSONDecoder().decode(SeatGeekResponse.self, from: $0.data)
        }.compactMap {
            $0.events.map { $0.toEvent() }
        }
    }
    
    //TODO: add paging
    
}
