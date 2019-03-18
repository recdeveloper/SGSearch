//
//  EventSearchViewController.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/15/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import UIKit

protocol EventSearchViewControllerDelegate: class {
    func eventSearchViewControllerDidUpdateText(_ searchController: EventSearchViewController, text: String)
}

class EventSearchViewController: UISearchController, UISearchResultsUpdating {
    
    weak var searchDelegate: EventSearchViewControllerDelegate?
    
    // MARK: init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        obscuresBackgroundDuringPresentation = false
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchBar.placeholder = "Try \"Festival\"" //TODO: move to a Strings file
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    // MARK: view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.tintColor = .white
        searchResultsUpdater = self
    }
    
    // MARK: delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
        let delegate = searchDelegate else { return }
        delegate.eventSearchViewControllerDidUpdateText(self, text: text)
    }
}
