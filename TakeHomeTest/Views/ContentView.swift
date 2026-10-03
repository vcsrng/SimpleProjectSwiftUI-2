//
//  ContentView.swift
//  TakeHomeTest
//
//  Created by Vincent Saranang on 03/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    let datas: [String]
    
    var body: some View {
        ScrollView{
            VStack(spacing:16){
                // Search
                Search(searchText: $searchText)
                
                // List
//                ForEach(datas, id: \.self){ data in
//                    
//                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            
        }
    }
}

#Preview {
    ContentView(datas: ["Hello", "Hallo"])
}
