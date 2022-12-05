//
//  SJAPILoader.swift
//  LIST&SEEK
//
//  Created by Arun SJ on 04/09/18.
//  Copyright © 2018 Arun SJ. All rights reserved.
//

import UIKit


open class SJAPILoader: UIView {
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let view = UIView(frame: bounds);
        view.backgroundColor = SJFrame.settings.loaderViewBackgroundColor;//UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1);
        view.frame = bounds
        
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                 UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
        animateOpacityToVisible(status: true, view: view);
        view.translatesAutoresizingMaskIntoConstraints = false;
        /*
         self.addConstraint(pin(item: view, attribute: NSLayoutAttribute.top))
         self.addConstraint(pin(item: view, attribute: NSLayoutAttribute.left))
         self.addConstraint(pin(item: view, attribute: NSLayoutAttribute.bottom))
         self.addConstraint(pin(item: view, attribute: NSLayoutAttribute.right))
         // Add our border here and every custom setup
         */
        // addActivityLoader(view: view);
        addActivityWithLogo(view: view);
        //addActivityLoader(view: view);
    }
    
    
    func pin(item:Any,attribute:NSLayoutConstraint.Attribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: attribute, relatedBy: NSLayoutConstraint.Relation.equal, toItem: item, attribute: attribute, multiplier: 1.0, constant: 0.0);
    }
    
    func addActivityLoader(view:UIView) -> Void {
        
        /*
         UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
         indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
         indicator.center = self.view.center;
         [self.view addSubview:indicator];
         [indicator bringSubviewToFront:self.view];
         [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
         */
        
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge);
        indicator.frame = CGRect(x: 0, y: 0, width: SJFrame.settings.loaderIconSize, height: SJFrame.settings.loaderIconSize);
        indicator.center = view.center;
        indicator.tintColor = UIColor(rgb: 0x00d7a2);
        view.addSubview(indicator);
        indicator.bringSubviewToFront(view);
        indicator.startAnimating();
    }
    
    func addActivityWithLogo(view:UIView) -> Void {
        let viewLogo = UIView(frame: CGRect(x: 0, y: 0, width: SJFrame.settings.loaderSize, height: SJFrame.settings.loaderSize));
        viewLogo.center = view.center;
        viewLogo.backgroundColor = SJFrame.settings.loaderBackgroundColor;//UIColor.clear;
        viewLogo.layer.cornerRadius = CGFloat(SJFrame.settings.loaderSize) * 0.5;
        viewLogo.layer.shadowColor = SJFrame.settings.loaderShadowColor.cgColor;//UIColor.lightGray.cgColor;
        viewLogo.layer.shadowOffset = CGSize(width: 1, height: 1);
        view.addSubview(viewLogo);
        
        
        if let image = UIImage(named: "loaderIcon"){
            let imgLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: SJFrame.settings.loaderIconSize, height: SJFrame.settings.loaderIconSize));
            imgLogo.backgroundColor = UIColor.clear
            imgLogo.image = image;
            imgLogo.contentMode = UIView.ContentMode.scaleAspectFit;
            imgLogo.layer.cornerRadius = CGFloat(SJFrame.settings.loaderIconSize) * 0.5;
            imgLogo.clipsToBounds = true
            view.addSubview(imgLogo);
            view.bringSubviewToFront(imgLogo);
            imgLogo.center = view.center;
            animateScaleUp(status: true, view: imgLogo);
        }else{
            viewLogo.backgroundColor = SJFrame.settings.loaderBackgroundColor//UIColor.white;
        }
        
        
        
        
        
        
        
        let backgroundShape = CAShapeLayer();
        backgroundShape.frame = frame
        backgroundShape.path = UIBezierPath(ovalIn: CGRect(x: viewLogo.frame.origin.x, y: viewLogo.frame.origin.y, width: viewLogo.frame.size.width - CGFloat(SJFrame.settings.loaderStrokeOffset), height: viewLogo.frame.size.height - CGFloat(SJFrame.settings.loaderStrokeOffset))).cgPath
        backgroundShape.position = view.center
        backgroundShape.strokeColor = SJFrame.settings.loaderStrokeColor.cgColor //UIColor(rgb: 0x38B1FF).cgColor//UIColor.black.cgColor
        backgroundShape.lineWidth = CGFloat(SJFrame.settings.loaderStrokeWidth);
        backgroundShape.fillColor = UIColor.clear.cgColor
        
        animateScaleUp(status: true, view: viewLogo);
        // animateScaleUp(status: true, view: imgLogo);
        
        var animations = [CABasicAnimation]()
        
        let animation1 = CABasicAnimation(keyPath: "strokeEnd")
        animation1.fromValue = 0
        animation1.toValue = 1;
        animation1.duration = 1.0;
        //animation1.autoreverses = true;
        //animation1.repeatCount = 20;
        animation1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn);
        animations.append(animation1);
        
        let animation2 = CABasicAnimation(keyPath: "strokeStart")
        animation2.beginTime = 0.5;
        animation2.fromValue = 0
        animation2.toValue = 1;
        animation2.duration = 1.0
        //animation2.autoreverses = true;
        //animation2.repeatCount = 20;
        animation2.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut);
        animations.append(animation2);
        
        let animation3 = CABasicAnimation(keyPath: "transform.rotation.z")
        animation3.fromValue = 0.0;
        animation3.toValue   = (2 * Double.pi);
        animation3.duration  = 1.5;
        animation3.repeatCount = MAXFLOAT;
        /*
         animation3.beginTime = 0.5;
         animation3.fromValue = 0
         animation3.toValue = 2 * Double.pi;
         animation3.duration = 1.0
         //animation2.autoreverses = true;
         //animation2.repeatCount = 20;
         animation3.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut);
         //animations.append(animation2);
         */
        let group = CAAnimationGroup()
        group.duration = 1.5
        group.repeatCount = Float.greatestFiniteMagnitude;
        group.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        group.animations = animations;
        group.isRemovedOnCompletion = false;
        
        
        backgroundShape.add(group, forKey: "slice");
        backgroundShape.add(animation3, forKey: "rotation");
        view.layer.addSublayer(backgroundShape);
    }
    
    func animateOpacityToVisible(status:Bool,view:UIView) -> Void {
        UIView.animate(withDuration: 0.3) {
            view.alpha = status ? 1 : 0;
        }
    }
    
    func animateScaleUp(status:Bool,view:UIView) -> Void {
        var scaleValue = (status==false) ? 1.0 : 0.5;
        view.layer.transform = CATransform3DMakeScale(CGFloat(scaleValue), CGFloat(scaleValue), 1);
        scaleValue = status ? 1.0 : 0.5;
        /*
         UIView.animate(withDuration: 0.3) {
         view.layer.transform = CATransform3DMakeScale(CGFloat(scaleValue), CGFloat(scaleValue), 1);
         }
         */
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            view.layer.transform = CATransform3DMakeScale(CGFloat(scaleValue), CGFloat(scaleValue), 1);
        }) { (status) in
            //
        };
    }
    
}
