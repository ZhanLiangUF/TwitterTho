//
//  PostViewController.swift
//  TwitterApplication
//
//  Created by Abby Juan on 2/15/16.
//  Copyright © 2016 ZhanLiang. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    @IBOutlet weak var profilepictureImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var atnameLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
   // var tweet: Tweet?
    override func viewDidLoad() {
        super.viewDidLoad()
  //  nameLabel.text = tweet!.user!.name
    //atnameLabel.text = "@"+(tweet!.user?.screenname)!
    //profilepictureImage.setImageWithURL((tweet!.user?.profileImageUrl)!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPost(sender: AnyObject) {
        if(messageTextField.text != nil){
            let message = messageTextField.text
            
            TwitterClient.sharedInstance.composeTweet(message!)
        }
    
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
