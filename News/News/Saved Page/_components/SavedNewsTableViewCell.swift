//
//  SavedNewsTableViewCell.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import UIKit

class SavedNewsTableViewCell: UITableViewCell {
    @IBOutlet weak var savedNewsImageView: UIImageView!
    @IBOutlet weak var savedNewsTitleLabel: UILabel!
    @IBOutlet weak var savedNewsDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
