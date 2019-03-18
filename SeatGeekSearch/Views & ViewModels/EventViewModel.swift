//
//  EventViewModel.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/17/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import UIKit

//TODO: move to own file
protocol Favoritable {
    var isFavorite: Bool { get }
}

class EventViewModel: Favoritable, Equatable {
    
    var locationName: String
    var title: String
    var displayDate: String
    var imageURL: URL?
    var isFavorite: Bool = false
    
    init(event: Event) {
        locationName = event.locationName
        title = event.title
        displayDate = event.date.prettyFormat()
        imageURL = event.imageURL
    }
    
    convenience init(event: Event, isFavorite: Bool) {
        self.init(event: event)
        self.isFavorite = isFavorite
    }
    
    static func == (lhs: EventViewModel, rhs: EventViewModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.displayDate == rhs.displayDate &&
            lhs.locationName == rhs.locationName
    }

}
