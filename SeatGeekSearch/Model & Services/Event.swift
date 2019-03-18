//
//  Ticket.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/13/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import Foundation

typealias ID = String

protocol Identifiable {
    var id: ID { get }
}

protocol Event: Identifiable {
    var id: ID { get }
    var locationName: String { get }
    var title: String { get }
    var date: Date { get }
    var imageURL: URL? { get }
}

struct SeatGeekEvent: Event { //TODO: decouple from file
    let id: ID
    let locationName: String
    let title: String
    let date: Date
    let imageURL: URL?
}
