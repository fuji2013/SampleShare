//
//  ViewController.swift
//  SampleShare
//
//  Created by fuhi1983 on 2015/02/01.
//  Copyright (c) 2015年 sample. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    let twitterBtn = UIButton.buttonWithType(.System) as UIButton
    let lineBtn = UIButton.buttonWithType(.System) as UIButton
    let copyBtn = UIButton.buttonWithType(.System) as UIButton

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // twitter
        self.twitterBtn.setTitle("Twitter", forState: .Normal)
        self.twitterBtn.addTarget(self, action: "pressBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.twitterBtn)
        
        // line
        self.lineBtn.setTitle("LINE", forState: .Normal)
        self.lineBtn.addTarget(self, action: "pressBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.lineBtn)
        
        // pasteboard copy
        self.copyBtn.setTitle("Copy", forState: .Normal)
        self.copyBtn.addTarget(self, action: "pressBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.copyBtn)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        var viewConstraints = [NSLayoutConstraint]()
        
        // twitter
        self.twitterBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        var twitterBtnConstraints = [NSLayoutConstraint]()
        twitterBtnConstraints.append(NSLayoutConstraint(item: self.twitterBtn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 80.0))
        twitterBtnConstraints.append(NSLayoutConstraint(item: self.twitterBtn, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40.0))
        viewConstraints.append(NSLayoutConstraint(item: self.twitterBtn, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 40.0))
        viewConstraints.append(NSLayoutConstraint(item: self.twitterBtn, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: -80.0))
        
        // line
        self.lineBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        var lineBtnConstraints = [NSLayoutConstraint]()
        lineBtnConstraints.append(NSLayoutConstraint(item: self.lineBtn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 80.0))
        lineBtnConstraints.append(NSLayoutConstraint(item: self.lineBtn, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40.0))
        viewConstraints.append(NSLayoutConstraint(item: self.lineBtn, attribute: .Top, relatedBy: .Equal, toItem: self.twitterBtn, attribute: .Bottom, multiplier: 1.0, constant: 40.0))
        viewConstraints.append(NSLayoutConstraint(item: self.lineBtn, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: -80.0))
        
        // line
        self.copyBtn.setTranslatesAutoresizingMaskIntoConstraints(false)
        var copyBtnConstraints = [NSLayoutConstraint]()
        copyBtnConstraints.append(NSLayoutConstraint(item: self.copyBtn, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 80.0))
        copyBtnConstraints.append(NSLayoutConstraint(item: self.copyBtn, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40.0))
        viewConstraints.append(NSLayoutConstraint(item: self.copyBtn, attribute: .Top, relatedBy: .Equal, toItem: self.lineBtn, attribute: .Bottom, multiplier: 1.0, constant: 40.0))
        viewConstraints.append(NSLayoutConstraint(item: self.copyBtn, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: -80.0))
        
        self.copyBtn.addConstraints(copyBtnConstraints)
        self.lineBtn.addConstraints(lineBtnConstraints)
        self.twitterBtn.addConstraints(twitterBtnConstraints)
        self.view.addConstraints(viewConstraints)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pressBtn(sender:UIButton){
        if sender.isEqual(self.twitterBtn){
            shareTwitter()
        }else if sender.isEqual(self.lineBtn){
            shareLINE()
        }else if sender.isEqual(self.copyBtn){
            shareCopy()
        }
    }
    
    // twitter Share
    private func shareTwitter(){
        let controller = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        controller.setInitialText("Happy Birthday!!!")
        controller.completionHandler = {
            result in
            if result == SLComposeViewControllerResult.Done{
                NSLog("Done")
            }else if result == SLComposeViewControllerResult.Cancelled{
                NSLog("Cancel")
            }
        }
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    // line
    private func shareLINE(){
        var message:String? = "Happy Birthday!!!"
        message = message!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        if message == nil{
            return
        }
        
        let LINEURLString = "line://msg/text/\(message!)"
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: LINEURLString)!){
            // LINEがインストールされている
            UIApplication.sharedApplication().openURL(NSURL(string: LINEURLString)!)
        }else{
            // LINEがインストールされていない
            let alert = UIAlertView(title: "Error", message: "Can't open LINE", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK")
            alert.show()
        }
    }
    
    // copy
    private func shareCopy(){
        var message:String = "Happy Birthday!!!"
        
        let pasteboard = UIPasteboard.generalPasteboard()
        pasteboard.setValue(message, forPasteboardType: "public.text")
    }
}

