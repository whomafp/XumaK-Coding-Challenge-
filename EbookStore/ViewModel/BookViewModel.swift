//
//  BookViewModel.swift
//  EbookStore
//
//  Created by Miguel Ángel Fonseca Pérez on 27/11/21.
//

import Foundation
import Combine
import UIKit

enum SearchStatus {
    case normal, filtered
}

class BookViewModel {
    var bookSuscriber : AnyCancellable?
    var bookTitles : [Book]?
    var filteredBooks : [Book]?
    var featuredBooks : [Book]?
    var searchStatus: SearchStatus = .normal
    
    var didFetchBooks:(() -> Void)?
    var didSearchResults: (() -> Void)?
    
    let maxNumberNumberItems = 10
    
    func fetch(){
        bookSuscriber = BookFetchService<[Book]?>().bookPublisher.sink(receiveCompletion: { error in
            switch error {
            case .failure(let failed):
                DispatchQueue.main.async {
                    debugPrint(failed.localizedDescription)
                }
                break
            case .finished:
                break
            }
        }, receiveValue:{ [weak self] booktitles in
            guard let titles = booktitles, titles.count > 0 else {return}
            self?.bookTitles = titles
            self?.configFeaturedBooks()
            self?.didFetchBooks?()
        })
        
    }
    
    
    func getCurrentBook(index : Int) -> Book? {
        switch searchStatus {
        case .normal:
            return  bookTitles?.compactMap{$0}[index]
        case .filtered:
            return filteredBooks?.compactMap{$0}[index]
        }
        
    }
    
    func getBooksCount() -> Int {
        switch searchStatus {
        case .normal:
            return self.bookTitles?.count ?? 0
        case .filtered:
            return self.filteredBooks?.count ?? 0
            
        }
    }
    
    
    func getFeaturedBook(index: Int) -> Book? {
        self.featuredBooks?.compactMap{$0}[index]
    }
    
    private func configFeaturedBooks() {
        let maxItems = self.bookTitles?.count ?? 0 >= maxNumberNumberItems ? maxNumberNumberItems : self.bookTitles?.count ?? 0
        let randomElements = self.bookTitles?.choose(maxItems)
        self.featuredBooks =  Array(randomElements ?? []) as [Book]
    }
}

extension BookViewModel { // MARK: Filter methods
    func filterBooks(searchCriteria: String){
        guard let books = self.bookTitles, books.count > 0 else { return }
        if searchCriteria.isEmpty || searchCriteria == "" {
            filteredBooks = books
            searchStatus = .normal
        } else {
            searchStatus = .filtered
            filteredBooks = books.filter {($0.title?.uppercased().contains(searchCriteria.uppercased()) ?? false)}
        }
        self.didSearchResults?()
    }
    
    func resetSearchFilter(){
        searchStatus = .normal
        self.didSearchResults?()
    }
}
