//
//  ViewController.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/13/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import UIKit
import SDWebImage

protocol EventDetailViewControllerDelegate: class {
    func eventDetailViewControllerDidTapFavorite(_ detailViewController: EventDetailViewController, event: EventViewModel)
}


class EventDetailViewController: UIViewController {
    
    weak var delegate: EventDetailViewControllerDelegate?
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var event: EventViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.hideBackButtonText()
        populateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.topViewController?.navigationItem.backBarButtonItem = nil
        navigationController?.navigationBar.barTintColor = .white
        super.viewWillAppear(animated)
    }
    
    // MARK: View Setup
    
    func populateViews() {
        guard let event = event else { return }
        setupImageView(with: event)
        dateLabel.text = event.displayDate
        locationLabel.text = event.locationName
        navigationItem.title = event.title
        navigationController?.navigationBar.fitLargeTitleToSize(title: event.title)
        setupFavoriteButton()
    }
    
    func setupImageView(with event: EventViewModel) {
        imageView.sd_setImage(with: event.imageURL, placeholderImage: UIImage(named: "event"), context: nil)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8 //TODO: constant somewhere
    }
    
    func setupFavoriteButton() {
        guard let event = event else { return }
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 70, bottom: 7, right: 0) //TODO: constant somewhere
        event.isFavorite ?
            button.setImage(UIImage.init(named: "heartSelected")?.withRenderingMode(.alwaysTemplate), for: .normal) :
            button.setImage(UIImage.init(named: "heartUnselected"), for: .normal)
        button.imageView?.tintColor = .red
        button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
  
    // MARK: Event
    
    @objc func didTapFavoriteButton() {
        guard let delegate = delegate,
            let event = event else { return }
        event.isFavorite = !event.isFavorite
        setupFavoriteButton()
        delegate.eventDetailViewControllerDidTapFavorite(self, event: event)
    }

}

