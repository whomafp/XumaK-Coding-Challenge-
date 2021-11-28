//
//  BookViewController.swift
//  EbookStore
//
//  Created by Miguel Ángel Fonseca Pérez on 27/11/21.
//

import Foundation
import UIKit
class BookDetailViewController : UIViewController {
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var backgroundImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    var book : Book?
    
    override func viewDidLoad() {
        setupDetail()
        title = "Book detail"
    }
    
    fileprivate func setupDetail(){
        guard let book = book else {return}
        titleLabel.text = "Title: \(book.title ?? "No title available")"
        authorLabel.text = "Author: \(book.author ?? "No author available")"
        synopsisLabel.text = "No synopsis available"
        backgroundImgView.loadThumbnail(urlSting: book.imageURL ?? "")
        bookImageView.loadThumbnail(urlSting: book.imageURL ?? "")
    }
    
    
}
