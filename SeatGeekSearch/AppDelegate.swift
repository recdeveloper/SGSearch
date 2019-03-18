//
//  AppDelegate.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/13/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var eventCoordinator: EventCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let eventCoordinator = EventCoordinator()
        eventCoordinator.start()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = eventCoordinator.navigationController
        window.makeKeyAndVisible()
        self.window = window
        self.eventCoordinator = eventCoordinator
        return true
    }
}
