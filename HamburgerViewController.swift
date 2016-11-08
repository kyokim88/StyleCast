//
//  HamburgerViewController.swift
//  StyleCast
//
//  Created by Kim, YoungKyo (CONT) on 11/6/16.
//  Copyright © 2016 Nguyen, Quan. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var feedView: UIView!
    
    var feedViewInitialCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        feedViewInitialCenter = feedView.center
        // Create a reference to the the appropriate storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        
        
        
        // Instantiate the desired view controller from the storyboard using the view controllers identifier
        // Cast is as the custom view controller type you created in order to access it's properties and methods
        let feedViewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        
        
        
        
        
        let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        displayContentController(containerView: feedView, content: feedViewController)
        
        displayContentController(containerView: menuView, content: menuViewController)
        
        
        //hideContentController(content: feedViewController)
        
        //hideContentController(content: menuViewController)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func displayContentController(containerView: UIView, content: UIViewController) {
        addChildViewController(content)
        containerView.addSubview(content.view)
        content.didMove(toParentViewController: self)
    }
    
    
    
    
    func hideContentController(content: UIViewController) {
        content.willMove(toParentViewController: nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        
        
        
        //let location = sender.location(in: view)
        //let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: feedView)
        let velocity = sender.velocity(in: feedView)
        
        
        if sender.state == .began {
            
            
            
            
            //print("Gesture began")
            
        } else if sender.state == .changed {
            print("Gesture is changing")
            
            
            if velocity.x > 0 {
                
                print("x>0")
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    
                    self.feedView.center.x = self.feedViewInitialCenter.x + translation.x
                    //self.laterImageView.center.x = self.laterImageCenter.x
                }, completion: {(finished: Bool) -> Void in
                    
                })
                
                
                
                
            }
                
            else if velocity.x < 0 {
                
                print("x<0")
                
                UIView.animate(withDuration: 0.5, animations: {
                    print("this", self.feedView.center.x)
                    print("initial", self.feedViewInitialCenter)
                    self.feedView.center.x = self.feedViewInitialCenter.x + 275 + translation.x
                    
                    //self.laterImageView.center.x = self.laterImageCenter.x
                }, completion: {(finished: Bool) -> Void in
                    
                })
            }
            
        } else if sender.state == .ended {
            //print("Gesture ended")
            
            print("ended")
            
            if velocity.x > 0 {
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    print("it was here")
                    print(self.feedView.center.x)
                    
                    self.feedView.center.x = self.feedViewInitialCenter.x + 275
                    //self.laterImageView.center.x = self.laterImageCenter.x
                }, completion: {(finished: Bool) -> Void in
                    
                })
                
                
                
                
                
            }
                
            else if velocity.x < 0 {
                
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.feedView.center.x = self.feedViewInitialCenter.x
                    
                    //self.laterImageView.center.x = self.laterImageCenter.x
                }, completion: {(finished: Bool) -> Void in
                    
                })
                
                
                
                
                
            }
            
            
            
        }
        
    }

}
