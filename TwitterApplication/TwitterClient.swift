//
//  TwitterClient.swift
//  TwitterApplication
//
//  Created by Abby Juan on 2/2/16.
//  Copyright © 2016 ZhanLiang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "MkFg8hX117y7qbSVoIcNtgqW1"
let twitterConsumerSecret = "sn5Wn1GiAR88wA0RX03WjKRBUsu0K4MAkpUMG2oEo04X62Bklo"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user:User?, error: NSError?) ->())?
    class var sharedInstance: TwitterClient {
        
        struct Static {
            static let instance =  TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret )
            
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
        
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            
            for tweet in tweets {
                print("text: \(tweet.text), created: \(tweet.createdAt)")
            }
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("It did not work")
                completion(tweets: nil, error: error)
                
                
        })
    }
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        //Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Error getting request token")
              
        }
    }
    func openURL(url: NSURL) {
        
        
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress:nil, success:{ (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                print("It worked!")
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user:user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("error getting user")
                    self.loginCompletion?(user:nil, error:error)
            })
            
            
            }) { (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user:nil, error: error)
        }
}

    func addLike(id: String) {
        TwitterClient.sharedInstance.POST("1.1/favorites/create.json?id=\(id)", parameters: nil, success: { (operation:NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successfully liked!")
            }) { (operation:NSURLSessionDataTask?, error: NSError!) -> Void in
                print("failed to like")
        }
    }
    
    func removeLike(id: String){
        TwitterClient.sharedInstance.POST("1.1/favorites/destroy.json?id=\(id)", parameters: nil, success: { (operation:NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successfully unliked")
            }) { (operation:NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Failed to unlike")
        }
    }
    
    func addRetweet(id: String) {
        TwitterClient.sharedInstance.POST("1.1/statuses/retweet/\(id).json", parameters: nil, success: { (operation:NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successfully retweeted")
            }) { (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
                print("failed to retweet")
        }
    }
    
    func removeRetweet(id: String) {
        TwitterClient.sharedInstance.POST("1.1/statuses/unretweet/\(id).json", parameters: nil, success: { (operation:NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("successfully unretweeted")
            }) { (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
                print("failed to unretweet")
        }
    }
}