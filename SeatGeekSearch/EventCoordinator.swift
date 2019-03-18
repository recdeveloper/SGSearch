//
//  EventCoordinator.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/15/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import UIKit


class EventCoordinator: EventSearchTableViewDelegate, EventSearchViewControllerDelegate, EventDetailViewControllerDelegate {
    
    let navigationController: UINavigationController
    let tableViewController: EventSearchTableViewController
    var detailViewController: EventDetailViewController?
    let dataCoordinator = EventDataCoordinator()
    //TODO: add 'Enum' State Handling for better management and testibility
    
    // MARK: main methods
    
    init() {
        let storyboard = UIStoryboard.main()
        navigationController = storyboard.instantiate()
        tableViewController = storyboard.instantiate()
        tableViewController.searchController = EventSearchViewController(searchResultsController: nil)
        tableViewController.searchController?.searchDelegate = self
    }
    
    func start() {
        navigationController.pushViewController(tableViewController, animated: false)
        tableViewController.delegate = self
        tableViewController.searchController?.searchDelegate = self
        showNoResults()
    }
    
    // MARK: State Management
    
    func showNoResults() {
        guard tableViewController.events.count > 0 else { return }
        tableViewController.events = [EventViewModel]()
    }
    
    func loadResults(search: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        dataCoordinator.search(query: search).done { //TODO: searches should happen in a strict Queue to avoid messy async
            self.tableViewController.events = $0
        }.ensure {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }.catch { _ in
            self.tableViewController.events = []
            self.tableViewController.showError(title: "Could not load search")
            //TODO: add title to strings file
        }
    }
    
    func showDetails(of event: EventViewModel) {
        let detailController:EventDetailViewController = UIStoryboard.main().instantiate()
        detailController.event = event
        detailController.delegate = self
        detailViewController = detailController
        navigationController.pushViewController(detailController, animated: true)
    }
    
    func updateFavorite(for event: EventViewModel) {
        guard let index = tableViewController.events.index(where: {event == $0}) else {
            fatalError("Must be valid Events Index")
        }
        event.isFavorite ?
            dataCoordinator.addFavorite(at: index) :
            dataCoordinator.removeFavorite(at: index)
        tableViewController.tableView.reloadData() //TODO: reload at index
    }
    
    // MARK: Delegates
    
    func eventTableViewDelegateDidSelectEvent(_ eventTableController: EventSearchTableViewController, event: EventViewModel) {
        showDetails(of: event)
    }
    
    func eventSearchViewControllerDidUpdateText(_ searchController: EventSearchViewController, text: String) {
        text.count > 0 ?
            loadResults(search: text) :
            showNoResults()
    }
    
    func eventDetailViewControllerDidTapFavorite(_ detailViewController: EventDetailViewController, event: EventViewModel) {
        updateFavorite(for: event)
    }
    
}
