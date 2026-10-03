//
//  Datalist.swift
//  TakeHomeTest
//
//  Created by Vincent Saranang on 03/10/26.
//

import Foundation

struct MusicResponse: Codable {
    let resultCount: Int
    let results: [Track]
}

struct Track: Codable, Identifiable, Equatable {
    let trackId: Int
    let trackName: String?
    let artistName: String?
    let collectionName: String?
    let artworkUrl100: String?
    let previewUrl: String?
    
    var id: Int { trackId }
}
