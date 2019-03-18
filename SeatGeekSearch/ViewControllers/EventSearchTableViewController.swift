//
//  EventSearchTableViewController.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/15/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import UIKit
import SDWebImage

// MARK: Delegate

protocol EventSearchTableViewDelegate: class {
    func eventTableViewDelegateDidSelectEvent(_ eventTableController: EventSearchTableViewController, event: EventViewModel)
}

// MARK: class

class EventSearchTableViewController: UITableViewController {

    weak var delegate: EventSearchTableViewDelegate?
    var searchController: EventSearchViewController?
    
    var events = [EventViewModel]() {
        didSet { tableView.reloadData() } //TODO: in the case of paging, this should be handled with insertions instead
    }
    
    // MARK: view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SeakGeek Search" //TODO: put in a Strings file
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        setupTableView()
        setupSearch()
    }
    
    var barTintColor: UIColor?
    override func viewWillAppear(_ animated: Bool) {
        if barTintColor == nil {
            barTintColor = navigationController?.navigationBar.barTintColor
        }
        navigationController?.navigationBar.barTintColor = barTintColor
        super.viewWillAppear(animated)
    }

    // MARK: appearance, setup
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupSearch() {
        if let searchController = searchController {
            navigationItem.searchController = searchController
        }
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 88.0 //TODO: put in a constant
        let nib = UINib(nibName: String(describing: EventTableViewCell.self), bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: String(describing: EventTableViewCell.self))
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventTableViewCell.self), for: indexPath) as? EventTableViewCell else {
            fatalError("Requires use of EventTableViewCells")
        }
        let event = events[indexPath.row]
        cell.titleLabel.text = event.title
        cell.locationLabel.text = event.locationName
        cell.bottomLabel.text = event.displayDate
        cell.thumbView.sd_setImage(with: event.imageURL, placeholderImage: UIImage(named: "event"), context: nil)
        if event.isFavorite {
            cell.favoriteImageView.image = UIImage.init(named: "heartBorder")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.eventTableViewDelegateDidSelectEvent(self, event: events[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
