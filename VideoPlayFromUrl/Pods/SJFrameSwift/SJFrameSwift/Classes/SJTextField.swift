//
//  SJTextField.swift
//  LIST&SEEK
//
//  Created by Arun SJ on 07/08/18.
//  Copyright © 2018 Arun SJ. All rights reserved.
//

import UIKit

open class SJTextField: UITextField {

    var toolBar:UIToolbar?;
    let winSize = UIScreen.main.bounds;
    
    var btnActionCompletion:((_ name:String)->Void)?;
    var arrayLeftSideButtons:[UIButton] = [UIButton]();
    var arrayRightSideButtons:[UIButton] = [UIButton]();
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func initialization() -> Void {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: winSize.size.width, height: 44));
        /*
        let tmpDoneBtn:UIButton = UIButton(type: UIButtonType.roundedRect);
        tmpDoneBtn.setTitle("Done", for: UIControlState.normal);
        tmpDoneBtn.titleLabel?.textColor = UIColor.blue;
        tmpDoneBtn.tintColor = UIColor.blue;
        tmpDoneBtn.backgroundColor = UIColor.red;
        tmpDoneBtn.sizeToFit();
        tmpDoneBtn.frame = CGRect(x: 5, y: 5, width: 80, height: 32);
        tmpDoneBtn.addTarget(self, action: #selector(btnAction), for: UIControlEvents.touchUpInside);
        toolBar?.items = [UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil),UIBarButtonItem(customView: tmpDoneBtn)];
        
        self.inputAccessoryView = toolBar;
        
        
        
        UIButton *tmpDoneBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [tmpDoneBtn setTitle:strBtn forState:UIControlStateNormal];
        [tmpDoneBtn.titleLabel setTextColor:self.toolbarButtonTitleColor];
        tmpDoneBtn.titleLabel.textColor=self.toolbarButtonTitleColor;
        [tmpDoneBtn setTintColor:self.toolbarButtonTitleColor];
        
        //        [tmpDoneBtn.titleLabel setFont:self.font];
        [tmpDoneBtn sizeToFit];
        [tmpDoneBtn setFrame:CGRectMake(50, 5, tmpDoneBtn.frame.size.width, 32)];
         */
        
    }
    
    func generateButtons(arrayButtonsName:[String],ofLeftSide:Bool)->Void{
        for name in arrayButtonsName{
            let tmpDoneBtn:UIButton = UIButton(type: UIButton.ButtonType.roundedRect);
            tmpDoneBtn.setTitle(" \(name) ", for: UIControl.State.normal);
            tmpDoneBtn.titleLabel?.textColor = self.textColor;
            tmpDoneBtn.titleLabel?.font = self.font;
            if let color = SJFrame.settings.textFieldToolbarTextColor{
                tmpDoneBtn.tintColor = color;
            }else{
                tmpDoneBtn.tintColor = self.textColor;
            }
            
            tmpDoneBtn.backgroundColor = UIColor.clear;
            tmpDoneBtn.sizeToFit();
            tmpDoneBtn.frame = CGRect(x: 5, y: 5, width: tmpDoneBtn.frame.width, height: 32);
            
            if(ofLeftSide){
                tmpDoneBtn.addTarget(self, action: #selector(btnLeftAction(sender:)), for: UIControl.Event.touchUpInside);
                arrayLeftSideButtons.append(tmpDoneBtn);
            }else{
                tmpDoneBtn.addTarget(self, action: #selector(btnRightAction(sender:)), for: UIControl.Event.touchUpInside);
                arrayRightSideButtons.append(tmpDoneBtn);
            }
        }
        setButtonsToToolBar();
    }
    
    @objc func btnLeftAction(sender:UIButton)->Void{
        for btn in arrayLeftSideButtons{
            if(btn == sender){
                btnActionCompletion!((btn.titleLabel?.text)!);
                break;
            }
        }
        
    }
    @objc func btnRightAction(sender:UIButton)->Void{
        for btn in arrayRightSideButtons{
            if(btn == sender){
                btnActionCompletion!((btn.titleLabel?.text)!);
                break;
            }
        }
    }
    
    func setButtonsToToolBar() -> Void {
        var arrayBtnAtToolBar:[UIBarButtonItem] = [UIBarButtonItem]();
        for btn in arrayLeftSideButtons{
            arrayBtnAtToolBar.append(UIBarButtonItem(customView: btn));
        }
        arrayBtnAtToolBar.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil));
        for btn in arrayRightSideButtons{
            arrayBtnAtToolBar.append(UIBarButtonItem(customView: btn));
        }
        toolBar?.items = arrayBtnAtToolBar;
        self.inputAccessoryView = toolBar;
    }
    
    public func addKeyboardRightSideToolBarButtons(names:[String],action:@escaping (_ btnName:String)->Void) -> Void {
        initialization();
        btnActionCompletion = action;
        arrayRightSideButtons.removeAll();
        generateButtons(arrayButtonsName: names, ofLeftSide: false);
    }
    
    public func addKeyboardLeftSideToolBarButtons(names:[String],action:@escaping (_ btnName:String)->Void) -> Void {
        initialization();
        btnActionCompletion = action;
        arrayLeftSideButtons.removeAll();
        generateButtons(arrayButtonsName: names, ofLeftSide: true);
    }
}


open class SJTextView: UITextView {
    
    var toolBar:UIToolbar?;
    let winSize = UIScreen.main.bounds;
    
    var btnActionCompletion:((_ name:String)->Void)?;
    var arrayLeftSideButtons:[UIButton] = [UIButton]();
    var arrayRightSideButtons:[UIButton] = [UIButton]();
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    func initialization() -> Void {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: winSize.size.width, height: 44));
        /*
         let tmpDoneBtn:UIButton = UIButton(type: UIButtonType.roundedRect);
         tmpDoneBtn.setTitle("Done", for: UIControlState.normal);
         tmpDoneBtn.titleLabel?.textColor = UIColor.blue;
         tmpDoneBtn.tintColor = UIColor.blue;
         tmpDoneBtn.backgroundColor = UIColor.red;
         tmpDoneBtn.sizeToFit();
         tmpDoneBtn.frame = CGRect(x: 5, y: 5, width: 80, height: 32);
         tmpDoneBtn.addTarget(self, action: #selector(btnAction), for: UIControlEvents.touchUpInside);
         toolBar?.items = [UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil),UIBarButtonItem(customView: tmpDoneBtn)];
         
         self.inputAccessoryView = toolBar;
         
         
         
         UIButton *tmpDoneBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
         
         [tmpDoneBtn setTitle:strBtn forState:UIControlStateNormal];
         [tmpDoneBtn.titleLabel setTextColor:self.toolbarButtonTitleColor];
         tmpDoneBtn.titleLabel.textColor=self.toolbarButtonTitleColor;
         [tmpDoneBtn setTintColor:self.toolbarButtonTitleColor];
         
         //        [tmpDoneBtn.titleLabel setFont:self.font];
         [tmpDoneBtn sizeToFit];
         [tmpDoneBtn setFrame:CGRectMake(50, 5, tmpDoneBtn.frame.size.width, 32)];
         */
        
    }
    
    func generateButtons(arrayButtonsName:[String],ofLeftSide:Bool)->Void{
        for name in arrayButtonsName{
            let tmpDoneBtn:UIButton = UIButton(type: UIButton.ButtonType.roundedRect);
            tmpDoneBtn.setTitle(" \(name) ", for: UIControl.State.normal);
            tmpDoneBtn.titleLabel?.textColor = self.textColor;
            tmpDoneBtn.titleLabel?.font = self.font;
            tmpDoneBtn.tintColor = self.textColor;
            tmpDoneBtn.backgroundColor = UIColor.clear;
            tmpDoneBtn.sizeToFit();
            tmpDoneBtn.frame = CGRect(x: 5, y: 5, width: tmpDoneBtn.frame.width, height: 32);
            
            if(ofLeftSide){
                tmpDoneBtn.addTarget(self, action: #selector(btnLeftAction(sender:)), for: UIControl.Event.touchUpInside);
                arrayLeftSideButtons.append(tmpDoneBtn);
            }else{
                tmpDoneBtn.addTarget(self, action: #selector(btnRightAction(sender:)), for: UIControl.Event.touchUpInside);
                arrayRightSideButtons.append(tmpDoneBtn);
            }
        }
        setButtonsToToolBar();
    }
    
    @objc func btnLeftAction(sender:UIButton)->Void{
        for btn in arrayLeftSideButtons{
            if(btn == sender){
                btnActionCompletion!((btn.titleLabel?.text)!);
                break;
            }
        }
        
    }
    @objc func btnRightAction(sender:UIButton)->Void{
        for btn in arrayRightSideButtons{
            if(btn == sender){
                btnActionCompletion!((btn.titleLabel?.text)!);
                break;
            }
        }
    }
    
    func setButtonsToToolBar() -> Void {
        var arrayBtnAtToolBar:[UIBarButtonItem] = [UIBarButtonItem]();
        for btn in arrayLeftSideButtons{
            arrayBtnAtToolBar.append(UIBarButtonItem(customView: btn));
        }
        arrayBtnAtToolBar.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil));
        for btn in arrayRightSideButtons{
            arrayBtnAtToolBar.append(UIBarButtonItem(customView: btn));
        }
        toolBar?.items = arrayBtnAtToolBar;
        self.inputAccessoryView = toolBar;
    }
    
    public func addKeyboardRightSideToolBarButtons(names:[String],action:@escaping (_ btnName:String)->Void) -> Void {
        initialization();
        btnActionCompletion = action;
        arrayRightSideButtons.removeAll();
        generateButtons(arrayButtonsName: names, ofLeftSide: false);
    }
    
    public func addKeyboardLeftSideToolBarButtons(names:[String],action:@escaping (_ btnName:String)->Void) -> Void {
        initialization();
        btnActionCompletion = action;
        arrayLeftSideButtons.removeAll();
        generateButtons(arrayButtonsName: names, ofLeftSide: true);
    }
}
