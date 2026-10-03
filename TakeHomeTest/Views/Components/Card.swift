//
//  Card.swift
//  TakeHomeTest
//
//  Created by Vincent Saranang on 03/10/26.
//

import SwiftUI

struct Card: View {
    var track: Track
    var isPlaying: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: track.artworkUrl100 ?? "")) { image in
                image.resizable()
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "music.note")
                            .foregroundColor(.gray)
                    )
            }
            .frame(width: 80, height: 80)
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(track.trackName ?? "Unknown Song")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text(track.artistName ?? "Unknown Artist")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                Text(track.collectionName ?? "Unknown Album")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if isPlaying {
                Image(systemName: "waveform")
                    .foregroundColor(.blue)
                    .imageScale(.large)
            }
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle()) // Makes the entire row tappable
    }
}
