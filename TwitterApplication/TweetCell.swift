//
//  TweetCell.swift
//  TwitterApplication
//
//  Created by Abby Juan on 2/10/16.
//  Copyright © 2016 ZhanLiang. All rights reserved.
//

import UIKit
import DateTools

class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var profilepictureImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var atnameLabel: UILabel!
    @IBOutlet weak var likecountLabel: UILabel!
    @IBOutlet weak var retweetcountLabel: UILabel!
    
    
    var retweet = false
    var like = false
    
    var tweet: Tweet! {
    
        didSet {
            retweetcountLabel.text = String(tweet.retweetCount!)
            likecountLabel.text = String(tweet.likeCount!)
            retweet = tweet.isRetweet!
            like = tweet.isLike!
            nameLabel.text = tweet.user!.name
            timeLabel.text = tweet.createdAt!.shortTimeAgoSinceNow()
            postLabel.text = tweet.text
            atnameLabel.text = "@"+(tweet.user?.screenname)!
            profilepictureImage.setImageWithURL((tweet.user?.profileImageUrl)!)
            if(tweet.isLike == true) {
                let origImage = UIImage(named: "iconmonstr-favorite-2-240")
                let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                likeButton.setImage(tintedImage, forState: .Normal)
                likeButton.tintColor = UIColor.redColor()
            } else if (tweet.isLike == false) {
                let origImage = UIImage(named: "iconmonstr-favorite-2-240")
                let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                likeButton.setImage(tintedImage, forState: .Normal)
                likeButton.tintColor = UIColor.grayColor()
            }
            if(tweet.isRetweet == true) {
                let origImage = UIImage(named: "iconmonstr-retweet-1-240")
                let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                retweetButton.setImage(tintedImage, forState: .Normal)
                retweetButton.tintColor = UIColor.greenColor()
            } else if (tweet.isRetweet == false) {
                let origImage = UIImage(named: "iconmonstr-retweet-1-240")
                let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                retweetButton.setImage(tintedImage, forState: .Normal)
                retweetButton.tintColor = UIColor.grayColor()
            }
            
            
            
            
        
        }
        
}
    
    
    @IBAction func onLike(sender: AnyObject) {
        like = !like
        if(like == true ) {
            print("1")
            tweet.likeCount = tweet.likeCount! + 1
            likeButton.tintColor = UIColor.redColor()
            TwitterClient.sharedInstance.addLike(tweet.id!)
            
        } else  {
            tweet.likeCount = tweet.likeCount! - 1
            likeButton.tintColor = UIColor.grayColor()
            TwitterClient.sharedInstance.removeLike(tweet.id!)
            
        }
       
    }

    
    
    
    @IBAction func onRetweet(sender: AnyObject) {
        retweet = !retweet
        if(retweet == true) {
            tweet.retweetCount = tweet.retweetCount! + 1
            retweetButton.tintColor = UIColor.greenColor()
            TwitterClient.sharedInstance.addRetweet(tweet.id!)
        } else {
            tweet.retweetCount = tweet.retweetCount! - 1
            retweetButton.tintColor = UIColor.grayColor()
            TwitterClient.sharedInstance.removeRetweet(tweet.id!)
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    atnameLabel.preferredMaxLayoutWidth = atnameLabel.frame.size.width
    nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    
    
    }
    override func layoutSubviews(){
        super.layoutSubviews()
    
    atnameLabel.preferredMaxLayoutWidth = atnameLabel.frame.size.width
    nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
