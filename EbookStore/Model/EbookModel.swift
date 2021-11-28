//
//  EbookModel.swift
//  EbookStore
//
//  Created by Miguel Ángel Fonseca Pérez on 27/11/21.
//

import Foundation


struct Book : Codable {
    let title : String?
    let author : String?
    let imageURL : String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case imageURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        title = try? container?.decode(String.self, forKey: .title)
        author = try? container?.decode(String.self, forKey: .author)
        imageURL = try? container?.decode(String.self, forKey: .imageURL)
        
    }
}
