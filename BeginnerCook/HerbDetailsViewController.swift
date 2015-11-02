//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by Dmitriy Roytman on 02.11.15.
//  Copyright © 2015 Underplot ltd. All rights reserved.
//

import UIKit

class HerbDetailsViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet var containerView: UIView!
    
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var titleView: UILabel!
    @IBOutlet var descriptionView: UITextView!
    @IBOutlet var licenseButton: UIButton!
    @IBOutlet var authorButton: UIButton!
    
    var herb: HerbModel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        bgImage.image = UIImage(named: herb.image)
        titleView.text = herb.name
        descriptionView.text = herb.description

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("actionClose:")))
    }
    
    func actionClose(tap: UITapGestureRecognizer) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    //MARK: button actions
    
    @IBAction func actionLicense(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: herb!.license)!)
    }

    @IBAction func actionAuthor(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: herb!.credit)!)
    }
    
    
}