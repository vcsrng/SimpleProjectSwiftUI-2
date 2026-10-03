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

struct PlayerControls: View {
    @ObservedObject var viewModel: MusicVM
    
    var body: some View {
        VStack(spacing: 8) {
            Slider(value: Binding(
                get: { viewModel.currentTime },
                set: { newValue in
                    viewModel.seek(to: newValue)
                }
            ), in: 0...(viewModel.duration > 0 ? viewModel.duration : 1))
            .padding(.horizontal)
            
            HStack(spacing: 40) {
                Button(action: {
                    viewModel.previousTrack()
                }) {
                    Image(systemName: "backward.fill")
                        .font(.title)
                        .foregroundColor(.primary)
                }
                
                Button(action: {
                    if viewModel.isPlaying {
                        viewModel.pause()
                    } else {
                        viewModel.play()
                    }
                }) {
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                }
                
                Button(action: {
                    viewModel.nextTrack()
                }) {
                    Image(systemName: "forward.fill")
                        .font(.title)
                        .foregroundColor(.primary)
                }
            }
            .padding(.bottom)
        }
        .padding(.top, 8)
        .background(Color(UIColor.systemBackground).shadow(radius: 2))
    }
}

#Preview {
    ContentView()
}
