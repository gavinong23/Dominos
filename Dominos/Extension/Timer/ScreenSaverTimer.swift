//
//  ScreenSaverTimer.swift
//  Dominos
//
//  Created by OngBoonFong on 26/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import Foundation
import UIKit


class ScreenSaverTimer{
    
    static let sharedTimer: ScreenSaverTimer = {
        let timer = ScreenSaverTimer()
        return timer
    }()
    var timer : Timer?
    
    let videoUrl = R.file.dominoVideoAdsMp4()
    
    
    fileprivate var player = Player()
    
     init(){
        player.playerDelegate = self as? PlayerDelegate
        player.playbackDelegate = self as? PlayerPlaybackDelegate
        print("init")
    }
    
    
    func startTimer(){
        print("start Timer")
        self.timer = Timer.scheduledTimer(timeInterval: Config.Timer.timeInterval, target: self, selector: #selector(self.playVideo), userInfo: nil, repeats: false)
    }
    
    
    func resetTimer(){
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: Config.Timer.timeInterval, target: self, selector: #selector(self.playVideo), userInfo: nil, repeats: false)
        self.player.stop()
        self.player.view.removeFromSuperview()
        self.player.removeFromParentViewController()
        print("reset timer")
    }
    
    func stopTimer(){
        self.timer?.invalidate()
        print("stop timer")
    }
    
    @objc func playVideo(){
        
        self.addPlayVideo()
        
        print("Play Video")
    }
    
    func addPlayVideo(){
        self.player.view.frame = UIScreen.main.bounds
        self.player.autoplay = true
        self.player.playbackLoops = true
        self.player.url = videoUrl
        self.player.fillMode = PlayerFillMode.resizeAspectFit.avFoundationType
        
        UIApplication.shared.keyWindow?.rootViewController?.addChildViewController(self.player)
        UIApplication.shared.keyWindow?.addSubview(self.player.view)
        //self.player.didMove(toParentViewController: self.window?.rootViewController)
        
        self.player.playFromBeginning()
        
        
    }
}




// MARK: - PlayerDelegate

extension AppDelegate:PlayerDelegate {
    
    func playerReady(_ player: Player) {
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
    }
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
    
}

// MARK: - PlayerPlaybackDelegate

extension AppDelegate:PlayerPlaybackDelegate {
    
    func playerCurrentTimeDidChange(_ player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
    }
    
    
    
    
}
