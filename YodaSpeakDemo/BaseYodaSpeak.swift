//
//  BaseYodaSpeak.swift
//  YodaSpeakDemo
//
//  Created by Soham Shirgaonkar on 1/29/16.
//  Copyright © 2016 soham. All rights reserved.
//

import UIKit

class BaseYodaSpeak: UIViewController {
    
    var screen_width = UIScreen.mainScreen().bounds.size.width;
    var screen_height = UIScreen.mainScreen().bounds.size.height;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func placeViewBelow(placeView view1:UIView, belowView view2:UIView, withOffset offset:Int)
    {
        var view1_frm = view1.frame;
        view1_frm.origin.y =  view2.frame.origin.y + view2.frame.size.height + CGFloat(offset);
        view1.frame = view1_frm;
    }
    
    func centerViewinX(view:UIView)
    {
        var v_frm = view.frame;
        v_frm.origin.x = (self.screen_width - v_frm.size.width)/2
        view.frame = v_frm;
    }
    
    func centerViewinY(view:UIView)
    {
        var v_frm = view.frame;
        v_frm.origin.y = (self.screen_height - v_frm.size.height)/2
        view.frame = v_frm;
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
