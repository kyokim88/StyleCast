//
//  LocationViewController.swift
//  StyleCast
//
//  Created by Nguyen, Quan on 11/4/16.
//  Copyright © 2016 Nguyen, Quan. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var blueSkyView: UIView!
    @IBOutlet weak var tabBarContainerView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var weatherButton: UIButton!
    @IBOutlet weak var stylesButton: UIButton!
    @IBOutlet weak var tipsButton: UIButton!
    
    @IBOutlet weak var tempText: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var tempStaringYValue: CGFloat = 0
    var tempStaringXValue: CGFloat = 0
    var tempStaringSize: CGFloat = 0
    
    var iconStaringYValue: CGFloat = 0
    var iconStaringXValue: CGFloat = 0
    var iconStaringSize: CGFloat = 0
    
    //make an array to hold tab bar buttons
    var buttons: [UIButton]!
    
    //vars to hold views associated with tabs
    var weatherViewController: UIViewController!
    var stylesViewController: UIViewController!
    var tipsViewController: UIViewController!
    
    //an array to hold all our view controllers
    var viewControllers: [UIViewController]!
    
    //define a variable to keep track of the tab button that is selected
    var selectedIndex: Int = 0
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = contentView.frame.size
        scrollView.delegate = self
        
        
        tempStaringYValue = tempText.frame.origin.y
        tempStaringXValue = tempText.frame.origin.x
        tempStaringSize = tempText.frame.size.width

        
        iconStaringYValue = iconImageView.frame.origin.y
        iconStaringXValue = iconImageView.frame.origin.x
        iconStaringSize = iconImageView.frame.size.width

        
        
        //link ViewController Vars to the ViewControllers in the Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //instantiate each ViewController by referencing storyboard and the particular ViewController's Storyboard ID
        weatherViewController = storyboard.instantiateViewController(withIdentifier: "WeatherControllerID")
        stylesViewController = storyboard.instantiateViewController(withIdentifier: "StylesControllerID")
        tipsViewController = storyboard.instantiateViewController(withIdentifier: "TipsControllerID")
        
        //add each ViewController to your viewControllers array
        viewControllers = [weatherViewController, stylesViewController, tipsViewController]
        
        //put the buttons in the defined array
        buttons = [weatherButton, stylesButton, tipsButton]
        
        //set default in content view
        buttons[selectedIndex].isSelected = true
        didPressTab(buttons[selectedIndex])


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPressTab(_ sender: UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        buttons[previousIndex].isSelected = false
        
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        
        addChildViewController(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        
        
        let offset = scrollView.contentOffset.y
        
        
        //when I scroll the list, degree image view changes the x position
        //        degreeStaringXValue = original - offset
        
        
        var nextXPosition = tempStaringXValue + offset
        if nextXPosition > 280 { nextXPosition = 280 }
        tempText.frame.origin = CGPoint(x: nextXPosition, y: tempText.frame.origin.y)
        
        
        
        
        // This method is called as the user scrolls
        
        var nextYPosition = tempStaringYValue - offset
        if nextYPosition < 30 { nextYPosition = 30 }
        tempText.frame.origin = CGPoint(x: tempText.frame.origin.x, y: nextYPosition)
        
        
        // This method is called as the user scrolls + size
        
        let change = 230 - offset
        let total: CGFloat = 230
        var percentOfTotal = change / total
        if percentOfTotal < 0.40 { percentOfTotal = 0.40 }
        //       if nextXPosition > 250 { nextScale = 1 }
        
        tempText.transform = CGAffineTransform(scaleX: percentOfTotal, y: percentOfTotal)
        
        //////-------------------------
        
        var iconnextYPosition = iconStaringYValue - offset
        if iconnextYPosition < 40 { iconnextYPosition = 40 }
        
        iconImageView.frame.origin = CGPoint(x: iconImageView.frame.origin.x, y: iconnextYPosition)
        
        
        
        var iconnextXPosition = iconStaringXValue - offset
        if iconnextXPosition < 30 { iconnextXPosition = 30 }
        iconImageView.frame.origin = CGPoint(x: iconnextXPosition, y: iconImageView.frame.origin.y)
        
        
        // This method is called as the user scrolls + size
        
        
        if percentOfTotal < 0.50 { percentOfTotal = 0.50 }
        //       if nextXPosition > 250 { nextScale = 1 }
        
        iconImageView.transform = CGAffineTransform(scaleX: percentOfTotal, y: percentOfTotal)
        
        
        
  
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
