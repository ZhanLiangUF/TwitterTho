//
//  Tweet.swift
//  TwitterApplication
//
//  Created by Abby Juan on 2/9/16.
//  Copyright © 2016 ZhanLiang. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String
    var createdAtString: String?
    var createdAt: NSDate?
    var isLike : Bool?
    var isRetweet : Bool?
    var retweetCount: Int?
    var id : String?
    var likeCount: Int?
    
    init(dictionary: NSDictionary)   {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = (dictionary["text"] as? String)!
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        id = dictionary["id_str"] as? String
        isLike = dictionary["favorited"] as? Bool
        isRetweet = dictionary["retweeted"] as? Bool
        retweetCount = dictionary["retweet_count"] as? Int
        likeCount = dictionary["favorite_count"] as? Int
        
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
            
       
        }
        return tweets
    }
}
