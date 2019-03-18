//
//  SeatGeekSearchTests.swift
//  SeatGeekSearchTests
//
//  Created by Rob Caraway on 3/13/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import XCTest
@testable import SeatGeekSearch

private struct Identity: Identifiable {
    let id: ID
}


class SeatGeekSearchTests: XCTestCase {

    let dataStore = SeatGeekDataStore()

    func testSeatGeekURL() {
        let url = URL.seatGeekRequest(query: "Total")
        XCTAssertTrue(url.isValidSeatGeekRequest())
        let badUrl = URL(string: "https://fakeWebsite.com/API")!
        XCTAssertFalse(badUrl.isValidSeatGeekRequest())
    }
    
    func testAddingToDateStore() {
        dataStore.add(identity: Identity(id: "123456"))
        XCTAssertTrue(dataStore.contains(identity: Identity(id: "123456")))
        dataStore.add(identity: Identity(id: "123456"))
        XCTAssertTrue(dataStore.contains(identity: Identity(id: "123456")))
    }
    
    func testRemovingFromDataStore() {
        dataStore.add(identity: Identity(id: "654321"))
        XCTAssertTrue(dataStore.contains(identity: Identity(id: "654321")))
        dataStore.remove(identity: Identity(id: "654321"))
        XCTAssertFalse(dataStore.contains(identity: Identity(id: "654321")))
        dataStore.add(identity: Identity(id: "654321"))
        dataStore.add(identity: Identity(id: "654321"))
        dataStore.remove(identity: Identity(id: "654321"))
        XCTAssertFalse(dataStore.contains(identity: Identity(id: "654321")))
    }
    
    func testDateFormatting() {
        let dateUnformatted = "2019-03-18T20:00:00"
        let date = dateUnformatted.toDate()
        XCTAssertNotNil(date)
        if let date = date {
            let dateString = date.prettyFormat()
            XCTAssertTrue("Mon, Mar 18, 2019 08:00 PM" == dateString)
        }
    }
    
    //TODO: measure API performance, add more exhaustive tests for DataStore, add formal Mock API tests, Test states of EventCoordinator
    //TODO: pull each component into own test file
    //TODO: run tests against any new build automatically
    
}
