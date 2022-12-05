//
//  SJNavigationController.swift
//  LIST&SEEK
//
//  Created by Arun SJ on 29/06/18.
//  Copyright © 2018 Arun SJ. All rights reserved.
//

import UIKit

open class SJNavigationController: UINavigationController,UIGestureRecognizerDelegate {
    lazy var slideInTransitioningDelegate = SlideInPresentationManager();
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        if(self.isNavigationBarHidden){
            self.interactivePopGestureRecognizer?.delegate = self;
        }
        // Do any additional setup after loading the view.
    }

    override open func viewWillAppear(_ animated: Bool) {
        
    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override open func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        super.setNavigationBarHidden(hidden, animated: animated);
        self.interactivePopGestureRecognizer?.delegate = self;
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(self.viewControllers.count>1){
            return true;
        }else{
            return false;
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    public func setPresentStyle(direction:PresentationDirection) -> Void {
        slideInTransitioningDelegate.direction = direction
        slideInTransitioningDelegate.disableCompactHeight = true
        self.transitioningDelegate = slideInTransitioningDelegate
        self.modalPresentationStyle = .custom
    }
}

