//
//  AboutView.swift
//  EbookStore
//
//  Created by Miguel Ángel Fonseca Pérez on 27/11/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            Color(red: 0.21, green: 0.23, blue: 0.28, opacity: 1)
                .ignoresSafeArea(.all)
            VStack {
                Image("Miguel")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 170)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 3))
                Text("Miguel Fonseca")
                    .font(.system( size: 40))
                    .bold()
                    .foregroundColor(.white)
                Text("iOS Developer.")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                Divider()
                InfoView(text: "+52 477-383-1658", imageName: "phone.fill")
                InfoView(text: "migueeelfoonseca@gmail.com", imageName: "envelope.fill")
            }
            
        }
    }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
class AboutVHC: UIHostingController<AboutView>{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: AboutView())
    }
}
