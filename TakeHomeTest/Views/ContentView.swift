//
//  ContentView.swift
//  TakeHomeTest
//
//  Created by Vincent Saranang on 03/10/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MusicVM()
    
    var body: some View {
        VStack(spacing: 0) {
            Search(searchText: $viewModel.searchText)
                .padding()
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(viewModel.datas) { data in
                    Card(track: data, isPlaying: viewModel.currentTrack == data && viewModel.isPlaying)
                        .onTapGesture {
                            viewModel.playTrack(data)
                        }
                }
                .listStyle(PlainListStyle())
            }
            
            if viewModel.currentTrack != nil {
                PlayerControls(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
