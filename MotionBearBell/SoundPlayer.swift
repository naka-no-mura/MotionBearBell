//
//  SoundPlayer.swift
//  MotionBearBell
//
//  Created by r.nakamura on 2022/11/26.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {
    
    // 鈴の音源データ読み込み
    let bellData = NSDataAsset(name: "suzu01")!.data
    
    // 鈴用プレイヤー
    var bellPlayer: AVAudioPlayer!
    
    func bellPlay() {
        do {
            bellPlayer = try AVAudioPlayer(data: bellData)
            
            bellPlayer.play()
        } catch {
            print("bell error")
        }
    }
    
    func bellPlayLoop() {
        do {
            bellPlayer = try AVAudioPlayer(data: bellData)

            bellPlayer.numberOfLoops = -1
            bellPlayer.play()
        } catch {
            print("bellloop error")
        }
    }
}
