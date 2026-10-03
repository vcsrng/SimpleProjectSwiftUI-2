//
//  Search.swift
//  TakeHomeTest
//
//  Created by Vincent Saranang on 03/10/26.
//

import SwiftUI

struct Search: View {
    @Binding var searchText: String
    
    var body: some View{
        HStack(alignment: .center ,spacing: 8){
            Image(systemName: "magnifyingglass")
            TextField(
                "Search artist",
                text: $searchText
            )
            .disableAutocorrection(true)
        }
        .padding()
        .background{
            Rectangle()
                .fill(.white)
                .stroke(.blue, lineWidth:2)
        }
    }
}
