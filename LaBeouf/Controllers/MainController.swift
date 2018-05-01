//
//  MainController.swift
//  LaBeouf
//
//  Created by Sergey Levkachev on 01/05/2018.
//  Copyright © 2018 Sergey Levkachev. All rights reserved.
//

import UIKit

protocol ModalHandler: class {
    func modalWillDismissing()
}

class MainController: UIViewController {
    
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var input: UIView!
    @IBOutlet weak var pageIndicator: UIStackView!
    @IBOutlet weak var bottomInputConstraint: NSLayoutConstraint!
    
    private let animator = PopAnimator()
    private weak var videoController: VideoController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedVideo()
    }
    
    @IBAction func showQuestion(_ sender: UIButton) {
        showDialog()
        adjustBottomElementsFor(isPresenting: false)
    }
    
    private func embedVideo() {
        let vc = StoryboardControllerFactory().createVideoController()
        embed(viewController: vc, in: videoContainer)
        videoController = vc
    }
    
    //Также можно передавать в DialogController экземпляр videoController, предварительно его настроив
    private func showDialog() {
        let vc = StoryboardControllerFactory()
            .createDialogController(transitioningDelegate: self,
                                    playVideoFrom: videoController?.currentSecond ?? 0)
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    private func adjustBottomElementsFor(isPresenting: Bool) {
        let targetY = isPresenting ? view.bounds.maxY - bottomInputConstraint.constant - input.bounds.height : view.bounds.maxY
        UIView.animate(withDuration: 0.3) {
            self.input.frame.origin.y = targetY
            self.pageIndicator.alpha = isPresenting ? 1 : 0
        }
    }
}

extension MainController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = false
        return animator
    }
}

extension MainController: ModalHandler {
    func modalWillDismissing() {
        adjustBottomElementsFor(isPresenting: true)
    }
}

