//
//  User.swift
//  TwitterApplication
//
//  Created by Abby Juan on 2/9/16.
//  Copyright © 2016 ZhanLiang. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "CurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: NSURL?
   
    var dictionary: NSDictionary
   
    
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let imageURLString = dictionary["profile_image_url"] as? String
        if imageURLString != nil {
            profileImageUrl = NSURL(string: imageURLString!)
            
        }else {
            profileImageUrl = nil
        }
        
    
    }
    
    func  logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    
    class var currentUser: User? {
        get{
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey (currentUserKey) as? NSData
                if data != nil {
                    do{
                    var dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
                    } catch{
                        
                    }
            }
        }
            return _currentUser
            
        }
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                do{
                    
                
                var data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: [])
            
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                }catch{
                    
                }
            
            }else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()

        }
    }
}