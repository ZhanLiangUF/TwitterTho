//
//  DetailViewController.swift
//  TwitterApplication
//
//  Created by Abby Juan on 2/14/16.
//  Copyright © 2016 ZhanLiang. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

   
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
   
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var atnameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilepictureImage: UIImageView!
    
    var retweet = true
    var like = true
    
    var tweet: Tweet?
            
    
            


    override func viewDidLoad() {
        super.viewDidLoad()
        
        retweet = tweet!.isRetweet!
        like = tweet!.isLike!
        nameLabel.text = tweet!.user!.name
        timeLabel.text = tweet!.createdAtString
        postLabel.text = tweet!.text
        atnameLabel.text = "@"+(tweet!.user?.screenname)!
        profilepictureImage.setImageWithURL((tweet!.user?.profileImageUrl)!)
        if(tweet!.isLike == true) {
            let origImage = UIImage(named: "iconmonstr-favorite-2-240")
            let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            likeButton.setImage(tintedImage, forState: .Normal)
            likeButton.tintColor = UIColor.redColor()
        } else if (tweet!.isLike == false) {
            let origImage = UIImage(named: "iconmonstr-favorite-2-240")
            let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            likeButton.setImage(tintedImage, forState: .Normal)
            likeButton.tintColor = UIColor.grayColor()
        }
        if(tweet!.isRetweet == true) {
            let origImage = UIImage(named: "iconmonstr-retweet-1-240")
            let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            retweetButton.setImage(tintedImage, forState: .Normal)
            retweetButton.tintColor = UIColor.greenColor()
        } else {
            let origImage = UIImage(named: "iconmonstr-retweet-1-240")
            let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            retweetButton.setImage(tintedImage, forState: .Normal)
            retweetButton.tintColor = UIColor.grayColor()
        }
        
        
        
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLike(sender: AnyObject) {
        like = !like
        if(like == true ) {
            print("1")
            tweet!.likeCount = tweet!.likeCount! + 1
            likeButton.tintColor = UIColor.redColor()
            TwitterClient.sharedInstance.addLike(tweet!.id!)
            
        } else  {
            tweet!.likeCount = tweet!.likeCount! - 1
            likeButton.tintColor = UIColor.grayColor()
            TwitterClient.sharedInstance.removeLike(tweet!.id!)
            
        }
    
    
    
    }
    
    
    @IBAction func onRetweet(sender: AnyObject) {
        retweet = !retweet
        if(retweet == true) {
            tweet!.retweetCount = tweet!.retweetCount! + 1
            retweetButton.tintColor = UIColor.greenColor()
            TwitterClient.sharedInstance.addRetweet(tweet!.id!)
        } else {
            tweet!.retweetCount = tweet!.retweetCount! - 1
            retweetButton.tintColor = UIColor.grayColor()
            TwitterClient.sharedInstance.removeRetweet(tweet!.id!)
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


