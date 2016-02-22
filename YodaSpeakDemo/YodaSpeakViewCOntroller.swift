//
//  YodaSpeakViewCOntroller.swift
//  YodaSpeakDemo
//
//  Created by Soham Shirgaonkar on 1/29/16.
//  Copyright © 2016 soham. All rights reserved.
//

import UIKit
import AVFoundation


class YodaSpeakViewCOntroller: BaseYodaSpeak,UITextFieldDelegate {
    var enter_txt: UITextField?
    var yoda_imageView:UIImageView?
    var click_me:UIButton?
    var resp_label:UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        self.setupYodaImage()
        self.setupTextBox()
        self.placeViewBelow(placeView: self.enter_txt!, belowView: self.yoda_imageView!, withOffset: 15)
        self.setupClickButton()
        self.placeViewBelow(placeView: self.click_me!, belowView: self.enter_txt!, withOffset: 10)
        self.setupResonseLabel()
        self.placeViewBelow(placeView: self.resp_label!, belowView: self.click_me!, withOffset: 15)
        self.centerViewinX(self.resp_label!)

    }
    
    func setupTextBox()
    {
        self.enter_txt = UITextField.init(frame: CGRectMake(0,50,self.screen_width-100, 40))
        self.enter_txt?.borderStyle = UITextBorderStyle.RoundedRect
        self.enter_txt?.delegate = self;
        self.centerViewinX(enter_txt!)
        self.view.addSubview(enter_txt!)
    }
    
    func setupYodaImage()
    {
        self.yoda_imageView = UIImageView.init(frame: CGRectMake(0,50,200, 200))
        self.yoda_imageView?.image = UIImage.init(named: "yoda.jpg")
        self.yoda_imageView?.layer.cornerRadius = 100
        self.yoda_imageView?.contentMode=UIViewContentMode.ScaleAspectFill
        self.yoda_imageView?.clipsToBounds=true
        self.centerViewinX(self.yoda_imageView!)
        self.view.addSubview(self.yoda_imageView!)
    }
    
    func setupClickButton()
    {
        self.click_me = UIButton.init(frame: CGRectMake(0, 0, 200,40))
        self.click_me?.setTitle("Click Me You Will!", forState: UIControlState.Normal)
        self.centerViewinX(self.click_me!)
        self.click_me?.layer.cornerRadius=5;
        self.click_me?.clipsToBounds=true
        self.click_me?.backgroundColor=UIColor(red: 0.91, green: 0.94, blue: 0.74, alpha: 1)
//        self.click_me?.backgroundColor = UIColor.greenColor()
        self.click_me?.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        self.view.addSubview(self.click_me!)
        self.click_me?.addTarget(self, action: "callAPI", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setupResonseLabel()
    {
        self.resp_label = UILabel.init(frame: CGRectMake(0, 0, self.screen_width-100,300))
        self.resp_label?.textColor = UIColor.darkGrayColor()
        self.resp_label?.text=""
        self.resp_label?.numberOfLines=0
        self.view.addSubview(self.resp_label!)
    }
    
    func callAPI()
    {
        self.enter_txt?.resignFirstResponder()
        print(self.enter_txt?.text)
        self.callAPIwithText((self.enter_txt!.text)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callAPIwithText(txt:String)
    {
        var act_ind = self.startActivityIndicator()
        
        let sentence = self.strEncode(txt)
        print(sentence)
        let url = NSURL.init(string: sentence)
        let url_req = NSMutableURLRequest(URL: url!)
        url_req.HTTPMethod = "GET"
        url_req.addValue("X17YSLGFyjmsh83lY6KePzuSCCMrp1RjEh4jsnE6GSIP0yXzHS", forHTTPHeaderField: "X-Mashape-Key")
        url_req.addValue("text/plain", forHTTPHeaderField: "Accept")
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(url_req, completionHandler: {(data, response, error) in
            print("In the completion block")
            let postdata = data
            let str_data = String(data: postdata!, encoding:NSASCIIStringEncoding)
            print("\(str_data)")
            let completer:dispatch_block_t={[weak self] in
                self!.resp_label!.text=str_data
                self!.resp_label!.sizeToFit()
                act_ind.stopAnimating()
                act_ind.removeFromSuperview()
                self?.yoda_speak(str_data!)
                print("End of Completion block")
            }
            dispatch_async(dispatch_get_main_queue(),completer)
            
        })
        task.resume()
    }
    
    
    func yoda_speak(str:String)
    {
        
        
        let string = str
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-au")

        
        let synthesizer = AVSpeechSynthesizer()
        utterance.pitchMultiplier = 0.3;
        
        synthesizer.speakUtterance(utterance)

    }
    
    func strEncode(str:String)->String
    {
        let main_str = "https://yoda.p.mashape.com/yoda?sentence="
        return main_str+str.stringByReplacingOccurrencesOfString(" ", withString: "+")
    }
    
    func startActivityIndicator()->UIActivityIndicatorView
    {
        var act = UIActivityIndicatorView.init(frame: CGRectMake(0, 0,100,100))
        act.color=UIColor.darkGrayColor()
        self.view.addSubview(act)
        self.centerViewinX(act)
        self.placeViewBelow(placeView: act, belowView: self.click_me!, withOffset: 10)
        act.startAnimating()
        return act
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
