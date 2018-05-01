//
//  VideoController.swift
//  LaBeouf
//
//  Created by Sergey Levkachev on 01/05/2018.
//  Copyright © 2018 Sergey Levkachev. All rights reserved.
//

import UIKit
import AVFoundation

class VideoController: UIViewController {
    
    private var player: AVPlayer!
    
    var currentSecond: Double {
        return player.currentTime().seconds
    }
    
    var path: String?
    var fromSecond: Double = 0
    var isMuted: Bool = false
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        adjustPlayer()
    }
    
    private func adjustPlayer() {
        guard player == nil, let path = path else { return }
        
        let videoUrl = URL(fileURLWithPath: path)
        let asset = AVAsset(url: videoUrl)
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        let layer = AVPlayerLayer(player: player)
        
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(layer)
        
        player.isMuted = isMuted
        player.seek(to: CMTime(seconds: fromSecond, preferredTimescale: 1000))
        player.play()
    }
}
