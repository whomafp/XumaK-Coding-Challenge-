//
//  BookAPI.swift
//  EbookStore
//
//  Created by Miguel Ángel Fonseca Pérez on 27/11/21.
//

import Foundation
import Combine

class BookFetchService <T:Codable> {
    private let urlStr = "http://de-coding-test.s3.amazonaws.com/books.json"
    //AnyPublisher is a type that cames from Combine
    var bookPublisher: AnyPublisher<T, Error>{
        let url : URL = URL(string : urlStr)!
        return URLSession.shared.dataTaskPublisher(for: url).map{$0.data}.decode(type: T.self, decoder: JSONDecoder()).receive(on: RunLoop.main).eraseToAnyPublisher()
    }
}
