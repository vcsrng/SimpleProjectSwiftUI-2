# Music Player
This is a simple but modern iOS music player. It's written entirely in SwiftUI and uses the MVVM pattern to keep the code clean, readable, and easy to maintain.

## What's Inside
- **Music Search**: Type in the search bar, and it will fetch artists and songs live from the iTunes Search API. (I added a small debounce so it doesn't spam the network).
- **Playback & Controls**: You can tap any song in the list to play it right away. The player controls (Play/Pause, Next, Previous, and a scrubbable progress slider) will pop up at the bottom. 
- **Auto-Play**: When a song finishes, it automatically rolls into the next track in the list.
- **Error & Loading States**: Added some basic UI feedback for when data is loading or if the network request fails.

## How it was Built

I tried to keep the architecture straightforward without over-engineering it:
- **MVVM**: The `MusicVM` handles all the heavy lifting—network calls (`URLSession`) and audio playback (`AVFoundation`). The views just observe and react to state changes.
- **Combine**: Used specifically for debouncing the search text input.
- **CI/CD**: I also threw in a quick GitHub Actions workflow (`ios.yml`) so the app builds automatically whenever code is pushed to the repo. 

## Getting Started
1. Clone this repo.
2. Open `TakeHomeTest.xcodeproj` in Xcode 27+ (or newer).
3. Pick a simulator (iPhone 18 Pro) and hit `Cmd + R` to run it.

---

## Project Timeline
Here is a rough breakdown:
- **Initial Setup**: Project scaffolding, setting up the file structure (`Views`, `ViewModels`, `Models`), and initializing the GitHub repository.
- **UI & Layout**: Building the core SwiftUI components based on the provided mockup (Search bar, Song Cards, and the bottom Player Controls).
- **Networking & Data**: Hooking up the iTunes Search API, parsing the JSON with `Codable`, and wiring it up to the ViewModel.
- **Audio Integration**: Getting `AVPlayer` to play the audio previews, tracking the playback progress for the slider, and handling the auto-play/skip logic.
- **Polish & CI/CD**: Adding loading/error states, writing this README, setting up the GitHub Action, and doing a final code cleanup.
