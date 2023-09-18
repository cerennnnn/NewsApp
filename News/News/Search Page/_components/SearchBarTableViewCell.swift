//
//  SearchBarTableViewCell.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import UIKit

class SearchBarTableViewCell: UITableViewCell {
    
    static let identifier = "SearchBarTableViewCell"

    @IBOutlet weak var searchTableViewImageView: UIImageView!
    @IBOutlet weak var searchTableViewTitleLabel: UILabel!
    @IBOutlet weak var searchTableViewDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
