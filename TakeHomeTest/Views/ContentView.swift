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
                if viewModel.datas.isEmpty{
                    VStack(spacing: 8){
                        Image(systemName: "magnifyingglass.circle")
                            .font(.system(size: 80))
                            .foregroundColor(.accentColor)
                            .symbolEffect(.rotate.byLayer, options: .repeat(.periodic(delay: 4.0)))
                        Text("Want to hear some music? go search the music")
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 48)
                            .multilineTextAlignment(.center)
                            .font(.title3)
                            .lineLimit(2, reservesSpace: false)
                    }
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
