//
//  ContentView.swift
//  DiaDetectFrontPage
//
//  Created by Bharathi Rajaram on 3/4/24.
//

import SwiftUI
import PhotosUI

struct DetectingView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State var image: UIImage?
    var body: some View {
        NavigationView{
            ZStack {
                
                Image ("Watercolor")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    
                    Spacer()
                    Text("Take a picture or upload an image to find your diagnosis")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding(.all)
                    
                    Spacer()
                    Button(action:{
                        
                    }){
                        Image(systemName: "camera")
                        Text("Take a picture")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    PhotosPicker("Select an image", selection: $selectedItem, matching: .images)
                        .onChange(of: selectedItem) {
                            Task {
                                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                                    image = UIImage(data: data)
                                }
                                print("Failed to load the image")
                            }
                        }
                    
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width:200, height: 200)
                        
                        NavigationLink(destination: RiskAssesmentView(image: image)) {
                            Text("Analyze Image") // More informative label
                        }
                        
                    }
                }
                
            }
        }
    }
}
#Preview {
    DetectingView()
}

