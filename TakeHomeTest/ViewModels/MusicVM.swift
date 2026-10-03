//
//  MusicVM.swift
//  TakeHomeTest
//
//  Created by Vincent Saranang on 03/10/26.
//

import Combine
import Foundation
import AVFoundation

@MainActor
final class MusicVM: ObservableObject {
    @Published var datas: [Track] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    // Player state
    @Published var currentTrack: Track? = nil
    @Published var isPlaying = false
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    
    private var player: AVPlayer?
    private var timeObserver: Any?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] keyword in
                guard let self = self else { return }
                if keyword.isEmpty {
                    self.datas = []
                } else {
                    self.fetchDatas(for: keyword)
                }
            }
            .store(in: &cancellables)
            
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
        }
    }
    
    func fetchDatas(for keyword: String) {
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://itunes.apple.com/search?term=\(encodedKeyword)&media=music&entity=song"
        guard let url = URL(string: urlString) else { return }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received."
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(MusicResponse.self, from: data)
                    self.datas = decodedData.results
                } catch {
                    self.errorMessage = "Error decoding JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    func playTrack(_ track: Track) {
        if currentTrack == track {
            if isPlaying {
                pause()
            } else {
                play()
            }
            return
        }
        
        guard let previewUrlString = track.previewUrl, let url = URL(string: previewUrlString) else { return }
        
        currentTrack = track
        setupPlayer(with: url)
    }
    
    private func setupPlayer(with url: URL) {
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
            timeObserver = nil
        }
        
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: 600), queue: .main) { [weak self] time in
            guard let self = self, let item = self.player?.currentItem else { return }
            self.currentTime = time.seconds
            if item.duration.isNumeric {
                self.duration = item.duration.seconds
            }
        }
        
        play()
    }
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func nextTrack() {
        guard let current = currentTrack, let index = datas.firstIndex(of: current) else { return }
        let nextIndex = index + 1
        if nextIndex < datas.count {
            playTrack(datas[nextIndex])
        } else {
            pause()
            currentTime = 0
        }
    }
    
    func previousTrack() {
        guard let current = currentTrack, let index = datas.firstIndex(of: current) else { return }
        let prevIndex = index - 1
        if prevIndex >= 0 {
            playTrack(datas[prevIndex])
        } else {
            seek(to: 0)
        }
    }
    
    func seek(to time: Double) {
        player?.seek(to: CMTime(seconds: time, preferredTimescale: 600))
    }
    
    @objc private func playerDidFinishPlaying(note: NSNotification) {
        if let item = note.object as? AVPlayerItem, item == player?.currentItem {
            DispatchQueue.main.async {
                self.nextTrack()
            }
        }
    }
}
