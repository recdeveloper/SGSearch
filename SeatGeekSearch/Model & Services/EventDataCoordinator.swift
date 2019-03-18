//
//  EventDataCoordinator.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/17/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import UIKit
import PromiseKit

class EventDataCoordinator {
    
    var events = [Event]()
    private let dataStore: IdDataStore = SeatGeekDataStore()
    
    func search(query: String) -> Promise<[EventViewModel]> {
        let service = EventAPIService(url: URL.seatGeekRequest(query: query))
        return firstly {
            service.search()
        }.compactMap {
            self.events = $0 ?? [Event]()
            return self.events.map { EventViewModel(event: $0, isFavorite: self.dataStore.contains(identity: $0))}
        }
    }
    
    func addFavorite(at index: Int) {
        let event = events[index]
        dataStore.add(identity: event)
    }
    
    func removeFavorite(at index: Int){
        let event = events[index]
        dataStore.remove(identity: event)
    }
}
