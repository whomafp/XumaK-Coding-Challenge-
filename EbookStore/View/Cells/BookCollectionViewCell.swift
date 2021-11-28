//
//  BookCollectionViewCell.swift
//  EbookStore
//
//  Created by Miguel Ángel Fonseca Pérez on 27/11/21.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var bookThumbnailImage: UIImageView!
    @IBOutlet weak var bookPic: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 4.0
        self.clipsToBounds = true
        self.bookThumbnailImage.contentMode = .scaleAspectFill
    }
    func setupCell(with booktitles: Book?) {
        guard let book = booktitles else { return }
        self.bookTitleLabel.text = book.title ?? .defaultNameValue
        self.authorLabel.text = book.author ?? ""
        if let thumbnail = book.imageURL {
            self.bookThumbnailImage.loadThumbnail(urlSting: thumbnail)
            self.bookPic.loadThumbnail(urlSting: thumbnail)
        } else {
            //TODO: set default thumbnail
        }
        
    }
}
