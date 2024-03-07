//
//  RiskAssesmentView.swift
//  DiaDetectFrontPage
//
//  Created by Bharathi Rajaram on 3/5/24.
//

import SwiftUI
import PhotosUI
import CoreML
import UIKit

extension UIImage {
    
    // https://www.hackingwithswift.com/whats-new-in-ios-11
    func toCVPixelBuffer() -> CVPixelBuffer? {
           
           let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
             var pixelBuffer : CVPixelBuffer?
             let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(self.size.width), Int(self.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
             guard (status == kCVReturnSuccess) else {
               return nil
             }

             CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
             let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

             let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
             let context = CGContext(data: pixelData, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

             context?.translateBy(x: 0, y: self.size.height)
             context?.scaleBy(x: 1.0, y: -1.0)

             UIGraphicsPushContext(context!)
             self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
             UIGraphicsPopContext()
             CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

             return pixelBuffer
       }
}



struct RiskAssesmentView: View {
    
    var imageClassifier: MobileNetV2?
    @State var image: UIImage
    @State private var classLabel: String = ""
    
    init() {
        do {
            imageClassifier = try MobileNetV2(configuration: MLModelConfiguration())
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        
        
        NavigationView{
            
            ZStack{
                Image ("Watercolor")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                    Button("Predict") {
                        guard let uiImage = image else { return }
                        
                        guard let pixelBuffer = uiImage.toCVPixelBuffer() else { return }
                        
                        do {
                            let result = try imageClassifier?.prediction(image: pixelBuffer)
                            result?.classLabel ?? ""
                        } catch{
                            print(error)
                        }
                        
                    }
                    
                    Text(classLabel)
                    
                    
                    // ... Your analysis logic or display elements using the 'image' ...
                }
            }
        }
    }
}



