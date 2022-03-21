//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Sergey Shcheglov on 16.03.2022.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)
            
            Text("Please select the resort in left-hand menu; swipe from the left edge to show it")
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
