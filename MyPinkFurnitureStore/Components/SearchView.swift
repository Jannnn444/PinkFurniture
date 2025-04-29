//
//  SearchView.swift
//  MyPinkFurnitureStore
//
//  Created by Hualiteq International on 2025/4/29.
//

import SwiftUI

struct SearchView: View {
    @State private var search: String = ""
    
    var body: some View {
        HStack {
            HStack {
                // Textfield
                Image(systemName: "magnifyingglass")
                    .padding(.leading)
                TextField("Search For Furniture", text: $search)
                    .padding()
            }
            .background(Color.kSecondary)
            .cornerRadius(12)
            // Cam at right side
            Image(systemName: "camera")
                .padding()
                .foregroundColor(.kPrimary)
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchView()
}
