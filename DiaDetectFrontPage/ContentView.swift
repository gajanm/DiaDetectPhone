//
//  ContentView.swift
//  DiaDetectFrontPage
//
//  Created by Bharathi Rajaram on 3/4/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {

            ZStack {
                Image ("Watercolor")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image ("retinapathyeyes")
                        .resizable()
                        .previewDisplayName("DiaDetect")
                        .aspectRatio(contentMode: .fit
                        )
                        .padding()
                    Spacer()
                    Text("DiaDetect")
                        .font(.title)
                    
                    Spacer()
                    Text("Find your level of diabetic reinopathy through DiaDetect, a deep learning algorithm that learns and improves based on data from multiple heathcare Institutions! \n\n Select \"Start Diagonsing\" to get your serverity estimate or select \"Learn more\" to see how the DiaDetect algorithm works")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(.all)
                    
                    Spacer()
                    NavigationLink(destination:DetectingView()){
                        Image(systemName: "magnifyingglass")
                        Text("Start Detecting")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    Button(action:{}){
                        Image(systemName: "book")
                        Text("Learn More")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
