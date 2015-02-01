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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // twitter
        self.twitterBtn.setTitle("Twitter", forState: .Normal)
        self.twitterBtn.addTarget(self, action: "pressBtn:", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.twitterBtn)
        
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
}

