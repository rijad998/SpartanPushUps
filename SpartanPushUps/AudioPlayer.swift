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

class AudioPlayer {

    var audioPlayer: AVAudioPlayer!
    var state: PlayedState!

    func playingSoundWith(fileName: String) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "wav")!)
            audioPlayer.prepareToPlay()
        } catch {
            print (error)
        }
    }

    var isPlaying: Bool {
        get {
            if let player = audioPlayer {
                return player.isPlaying
            }
            return false
        }
    }

}
