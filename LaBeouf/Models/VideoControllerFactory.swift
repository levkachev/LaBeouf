//
//  VideoControllerFactory.swift
//  LaBeouf
//
//  Created by Sergey Levkachev on 01/05/2018.
//  Copyright © 2018 Sergey Levkachev. All rights reserved.
//

import UIKit

protocol VideoControllerFactory {
    func createVideoController(pathToVideo: String?, startSecond: Double, isMuted: Bool) -> VideoController
}

protocol DialogControllerFactory {
    func createDialogController(transitioningDelegate: UIViewControllerTransitioningDelegate, playVideoFrom second: Double) -> DialogController
}

class StoryboardControllerFactory {
    let storyboard: UIStoryboard
    
    init(storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) {
        self.storyboard = storyboard
    }
}

extension StoryboardControllerFactory: VideoControllerFactory {
    func createVideoController(
        pathToVideo: String? = Bundle.main.path(forResource: "bg-video", ofType: "mov"),
        startSecond: Double = 0,
        isMuted: Bool = false) -> VideoController {
        let vc = storyboard.instantiateViewController(withIdentifier: "VideoController") as! VideoController
        vc.fromSecond = startSecond
        vc.isMuted = isMuted
        vc.path = pathToVideo
        return vc
    }
}

extension StoryboardControllerFactory: DialogControllerFactory {
    func createDialogController(transitioningDelegate: UIViewControllerTransitioningDelegate, playVideoFrom second: Double = 0) -> DialogController {
        let vc = storyboard.instantiateViewController(withIdentifier: "DialogController") as! DialogController
        vc.transitioningDelegate = transitioningDelegate
        vc.fromSecond = second
        return vc
    }
    
}
