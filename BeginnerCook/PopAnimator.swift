//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by Dmitriy Roytman on 02.11.15.
//  Copyright © 2015 Underplot ltd. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: Public properties
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    // MARK: UIViewControllerAnimatedTransitioning methods
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        
        let widthInitialFinal = initialFrame.width / finalFrame.width
        let widthFinalInitial = finalFrame.width / initialFrame.width
        let xScaleFactor = presenting ? widthInitialFinal : widthFinalInitial
        
        let heightInitialFinal = initialFrame.height / finalFrame.height
        let heightFinalInitial = finalFrame.height / initialFrame.height
        let yScaleFactor = presenting ? heightInitialFinal : heightFinalInitial
        
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(x: CGRectGetMidX(initialFrame), y: CGRectGetMidY(initialFrame))
            herbView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(herbView)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
                herbView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
                herbView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
            }) { _ in
                transitionContext.completeTransition(true)
        }
        
        let round = CABasicAnimation(keyPath: "cornerRadius")
        round.fromValue = presenting ? 20.0/xScaleFactor : 0.0
        round.toValue = presenting ? 0.0 : 20.0/xScaleFactor
        round.duration = duration / 2
        herbView.layer.addAnimation(round, forKey: nil)
        herbView.layer.cornerRadius = presenting ? 0.0 : 20.0/xScaleFactor

    }
}
