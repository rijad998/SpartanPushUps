//
//  AudioPlayer.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 11/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import AVFoundation

enum PlayedState {
    case muted
    case unMuted
}

/// Audio Player class that is in charge of playing sounds,
/// mostly, at the end of a timer
class AudioPlayer {

    var audioPlayer: AVAudioPlayer!
    var state: PlayedState!

    /// Function that receives name of the sound and create audio player
    /// that will later play that sound
    ///
    /// - Parameter fileName: sound name
    func playingSoundWith(fileName: String) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "wav")!)
            audioPlayer.prepareToPlay()
        } catch {
            print (error)
        }
    }

    /// Function that is checking existance of the audio player
    /// and if it exists does it play any sound
    var isPlaying: Bool {
        get {
            if let player = audioPlayer {
                return player.isPlaying
            }
            return false
        }
    }
}
