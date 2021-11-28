//
//  FeaturedBookViewController.swift
//  EbookStore
//
//  Created by Miguel Ángel Fonseca Pérez on 27/11/21.
//

import Foundation
import UIKit
class FeaturedViewController : UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel = BookViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = "Top Books"
        setupViewModel()
    }
    
    private func setupViewModel(){
        viewModel.didFetchBooks = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
            }
        }
        viewModel.fetch()
    }
    
}

extension FeaturedViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let titles = self.viewModel.featuredBooks, titles.count > 0 else { return 0 }
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentBook = self.viewModel.getFeaturedBook(index: indexPath.item) else {return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! featuredTableViewCell
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        cell.imageBook.layer.cornerRadius = cell.imageBook.frame.height / 2
        cell.bookNumberLabel.text = "\((indexPath.item + 1))"
        cell.titleBookLabel.text = currentBook.title ?? ""
        cell.subtitleBookLabel.text = currentBook.author ?? ""
        cell.imageBook.loadThumbnail(urlSting: currentBook.imageURL ?? "")
        cell.subtitleBookLabel.isHidden = currentBook.author == nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedBook = self.viewModel.getFeaturedBook(index: indexPath.item) else { return }
        showBookInfo(selectedBook)
    }
    
    fileprivate func showBookInfo(_ book : Book) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailBookController") as? BookDetailViewController {
            vc.book = book
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
