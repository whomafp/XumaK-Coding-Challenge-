//
//  featuredTableViewCell.swift
//  EbookStore
//
//  Created by Miguel Ángel Fonseca Pérez on 27/11/21.
//

import UIKit

class featuredTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleBookLabel: UILabel!
    @IBOutlet weak var subtitleBookLabel: UILabel!
    @IBOutlet weak var bookNumberLabel: UILabel!
    @IBOutlet weak var imageBook: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
