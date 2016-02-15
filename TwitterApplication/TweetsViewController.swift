//
//  TweetsViewController.swift
//  TwitterApplication
//
//  Created by Abby Juan on 2/9/16.
//  Copyright © 2016 ZhanLiang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        // Do any additional setup after loading the view.
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil , completion: { (tweets, error) -> () in
        self.tweets = tweets
        self.tableView.reloadData()
        //reload tableview here
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as!TweetCell
        
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
        
    }
    
    // MARK: - Navigation

   // In a storyboard-based application, you will often
   // want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailSegue"){
            print("detailSegue")
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.tweet = tweet
        } else if(segue.identifier == "profileSegue") {
    
                print("profileSegue")
            
           
            
            
            
        }
            
            
            
        }
    
    //Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    


}
