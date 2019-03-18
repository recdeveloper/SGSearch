//
//  EventTableViewCell.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/15/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbView.contentMode = .scaleAspectFill
        thumbView.clipsToBounds = true
        thumbView.layer.cornerRadius = 8
    }
    
    override func prepareForReuse() {
        bottomLabel.text = ""
        locationLabel.text = ""
        titleLabel.text = ""
        favoriteImageView.image = nil
        thumbView.image = nil
    }
    
}
