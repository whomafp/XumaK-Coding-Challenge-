//
//  InfoView.swift
//  EbookStore
//
//  Created by Miguel Ángel Fonseca Pérez on 27/11/21.
//

import SwiftUI

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "HELLO", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
    
}

struct InfoView: View {
    let text : String
    let imageName : String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .foregroundColor(.white)
            .frame(height: 40)
            .overlay(
                HStack {
                    Image(systemName: imageName)
                        .foregroundColor(.blue)
                    Text(text).foregroundColor(.black)
                    
                }).padding(.all)
    }
}
