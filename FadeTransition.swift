//
//  FadeTransition.swift
//  transitionDemo
//
//  Created by Timothy Lee on 11/4/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class FadeTransition: BaseTransition {
    
    var tempImageView: UIImageView!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        let navigationController = fromViewController as! UINavigationController
        let locationViewController = navigationController.topViewController as! LocationViewController
        let stylesViewController = locationViewController.stylesViewController as! PhotoCollectionViewController
        
        let toViewController = toViewController as! PhotoDetailsViewController
        
        stylesViewController.selectedImageView.isHidden = true
        toViewController.imageView.isHidden = true
        toViewController.hideAttributesView()
        
        tempImageView = UIImageView()
        tempImageView.image = stylesViewController.selectedImageView.image

        let frame = containerView.convert(stylesViewController.selectedImageView.frame, from: stylesViewController.selectedImageView.superview)
        tempImageView.frame = frame
        tempImageView.contentMode = stylesViewController.selectedImageView.contentMode
        tempImageView.clipsToBounds = stylesViewController.selectedImageView.clipsToBounds
        
        containerView.addSubview(tempImageView)
        
        toViewController.view.alpha = 0
        
        let destinationFrame = containerView.convert(toViewController.imageView.frame, from: toViewController.imageView.superview)
        
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.alpha = 1
            self.tempImageView.frame = destinationFrame
        }) { (finished: Bool) -> Void in
            stylesViewController.selectedImageView.isHidden = false
            toViewController.imageView.isHidden = false
            toViewController.showAttributesView()
            
            self.tempImageView.removeFromSuperview()
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        fromViewController.view.alpha = 1
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.alpha = 0
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
}
