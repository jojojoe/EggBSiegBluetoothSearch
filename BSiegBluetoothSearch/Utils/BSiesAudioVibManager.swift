//
//  BSiesAudioVibManager.swift
//  BSiegBluetoothSearch
//
//  Created by Joe on 2023/4/15.
//

import Foundation
import AVFoundation
import SwiftyTimer


class BSiesAudioVibManager: NSObject {

    enum AudioType: String {
        case veryslow = "did_slowslow.mp3"
        case slow = "did_slow.mp3"
        case fast = "did_fast.mp3"
    }
    
    var sudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    static let `default` = BSiesAudioVibManager()
    var audioPlayer: AVAudioPlayer?
    var currentAudioType: AudioType?
    let feedvis = UIImpactFeedbackGenerator.init(style: .heavy)
    var feedTimer: Timer?
    
    func audioSlowType() -> AudioType {
        if let item = BSiesBabyBlueManager.default.currentTrackingItem {
            let persent = item.deviceDistancePercent()
            if persent <= 0.3 {
                return .veryslow
            } else if persent <= 0.7 {
                return .slow
            } else {
                return .fast
            }
        }
        return .veryslow
    }
    
    func playAudio() {
        
        let prepareAudioType = audioSlowType()
        if prepareAudioType == currentAudioType {
            return
        }
        
        currentAudioType = prepareAudioType
        
        if audioPlayer?.isPlaying == true {
            stopAudio()
        }
        if let bundlePath = Bundle.main.path(forResource: prepareAudioType.rawValue, ofType: nil), let url = URL(string: bundlePath) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.delegate = self
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                debugPrint("error = \(error.localizedDescription)")
            }
        }
    }
    
    func stopAudio() {
        if let audioP = audioPlayer {
            audioP.stop()
            audioPlayer = nil
            currentAudioType = nil
        }
        
        
    }
    
    
    
}
extension BSiesAudioVibManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
    }
    
    
}

extension BSiesAudioVibManager {
    func feedVibInterval() -> TimeInterval {
        if let item = BSiesBabyBlueManager.default.currentTrackingItem {
            let persent = item.deviceDistancePercent()
            if persent <= 0.3 {
                return 4
            } else if persent <= 0.7 {
                return 2
            } else {
                return 0.3
            }
        }
        return 1
    }
    
    func playFeedVib() {
        
        func addnewTimer(interval: TimeInterval) {
            let timer = Timer.new(every: interval) {
                [weak self] in
                guard let `self` = self else {return}
                self.feedvis.impactOccurred(intensity: 1)
            }
            feedTimer = timer
            timer.start()
        }
        
        if let timer = feedTimer {
            timer.invalidate()
            feedTimer = nil
        }
        addnewTimer(interval: feedVibInterval())
        
        
    }
    
    func stopFeedVib() {
        if let timer = feedTimer {
            timer.invalidate()
            feedTimer = nil
        }
    }
}
