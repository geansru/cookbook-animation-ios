//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by Dmitriy Roytman on 02.11.15.
//  Copyright © 2015 Underplot ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet var listView: UIScrollView!
    @IBOutlet var bgImage: UIImageView!
    
    // MARK: Public properties
    var selectedImage: UIImageView?
    let transition = PopAnimator()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Public methods
    func didTapImageView(tap: UITapGestureRecognizer) {
        selectedImage = tap.view as? UIImageView
        
        let index = tap.view!.tag
        let selectedHerb = herbs[index]
        
        //present details view controller
        let herbDetails = storyboard!.instantiateViewControllerWithIdentifier("HerbDetailsViewController") as! HerbDetailsViewController
        herbDetails.herb = selectedHerb
        herbDetails.transitioningDelegate = self
        presentViewController(herbDetails, animated: true, completion: nil)
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension ViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame =
            selectedImage!.superview!.convertRect(selectedImage!.frame, toView: nil)
        
        transition.presenting = true
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}