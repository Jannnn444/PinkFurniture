//
//  ImageSliderView.swift
//  MyPinkFurnitureStore
//
//  Created by Hualiteq International on 2025/4/29.
//

import SwiftUI

struct ImageSliderView: View {
    @State private var currentIndex = 0
    var sliders: [String] = ["fn1", "fn2", "fn3", "fn4", "fn5", "fn6",]
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack(alignment: .trailing) {
                Image(sliders[currentIndex])
                    .resizable()
                    .frame(width: .infinity, height: 180)
                    .scaledToFit()
                    .cornerRadius(15)
            }
            HStack {
                ForEach(0..<sliders.count) { index in
                    Circle()
                        .fill(self.currentIndex == index ? Color("kPrimary") : Color("kSecondary"))
                        .frame(width: 10, height: 10)
                }
            }.padding()
        }
        .padding()
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                // reset when it goes to the last one
                if self.currentIndex + 1 == self.sliders.count {
                    self.currentIndex = 0
                } else {
                    self.currentIndex += 1
                }
            }
        }
        
    }
}

#Preview {
    ImageSliderView()
}
