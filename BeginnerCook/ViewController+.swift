//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by Dmitriy Roytman on 02.11.15.
//  Copyright © 2015 Underplot ltd. All rights reserved.
//

import UIKit

//data models
let herbs = HerbModel.all()

extension ViewController: UIScrollViewDelegate {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if listView.subviews.count < herbs.count {
            listView.viewWithTag(0)?.tag = 1000 //prevent confusion when looking up images
            setupList()
        }
    }
    
    //add all images to the list
    func setupList() {
        
        for var i=0; i < herbs.count; i++ {

            //create image view
            let imageView  = UIImageView(image: UIImage(named: herbs[i].image))
            imageView.tag = i
            imageView.contentMode = .ScaleAspectFill
            imageView.userInteractionEnabled = true
            imageView.layer.cornerRadius = 20.0
            imageView.layer.masksToBounds = true
            listView.addSubview(imageView)

            //attach tap detector
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTapImageView:")))
        }
        
        listView.backgroundColor = UIColor.clearColor()
        positionListItems()
    }
    
    //position all images inside the list
    func positionListItems() {
        
        let ratio = view.frame.size.height / view.frame.size.width
        let itemHeight: CGFloat = listView.frame.height * 1.33
        let itemWidth: CGFloat = itemHeight / ratio
      
        let horizontalPadding: CGFloat = 10.0
        
        for var i=0; i < herbs.count; i++ {
            let imageView = listView.viewWithTag(i) as! UIImageView
            imageView.frame = CGRect(
                x: CGFloat(i) * itemWidth + CGFloat(i+1) * horizontalPadding, y: 0.0,
                width: itemWidth, height: itemHeight)
        }
        
        listView.contentSize = CGSize(
            width: CGFloat(herbs.count) * (itemWidth + horizontalPadding) + horizontalPadding,
            height:  0)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}