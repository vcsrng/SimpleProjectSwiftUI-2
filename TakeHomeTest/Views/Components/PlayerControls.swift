//
//  PlayerControls.swift
//  TakeHomeTest
//
//  Created by Vincent Saranang on 03/10/26.
//

import SwiftUI

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
                    Image(systemName: "backward.end.alt.fill")
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
                    Image(systemName: "forward.end.alt.fill")
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
