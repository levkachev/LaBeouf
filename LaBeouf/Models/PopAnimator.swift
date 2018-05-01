//
//  PopAnimator.swift
//  LaBeouf
//
//  Created by Sergey Levkachev on 01/05/2018.
//  Copyright © 2018 Sergey Levkachev. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration = 0.5
    private var originFrame = CGRect.zero
    
    var presenting = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let key: UITransitionContextViewControllerKey = presenting ? .to : .from
        
        guard let popup = transitionContext.viewController(forKey: key) as? DialogController,
            let popupView = popup.view,
            let blur = popup.blurView,
            let dialog = popup.contentView
            else { return }
        
        let alpha: CGFloat = presenting ? 0 : 1
        blur.alpha = alpha
        dialog.alpha = alpha
        
        let scale: CGFloat = presenting ? 0.8 : 1
        dialog.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        containerView.addSubview(popupView)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, animations: {
            
            let alpha: CGFloat = self.presenting ? 1 : 0
            blur.alpha = alpha
            dialog.alpha = alpha
            
            let scale: CGFloat = self.presenting ? 1 : 0.8
            dialog.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
        
    }
}
