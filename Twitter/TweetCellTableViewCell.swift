//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Lauren Work on 10/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func retweetAction(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetID, success: {
            self.setRetweeted(true)
        }, failure: {
            (error) in
            print("Error in retweeting: \(error)")
        })
    }
    

    @IBAction func favoriteAction(_ sender: Any) {
        let toBeFavorited = !favorited
        if (tweetID != -1) {
            if(toBeFavorited) {
                TwitterAPICaller.client?.favoriteTweet(tweetId: tweetID, success: {
                    self.setFavorited(true)
                }, failure: { (error) in
                    print("Favorite did not succeed: \(error)")
                })
            } else {
                TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetID, success: {
                    self.setFavorited(false)
                }, failure: { (error) in
                    print("Unfavorite did not succeed: \(error)")
                })
            }
        }
    }
    
    var favorited:Bool = false
    var retweeted:Bool = false
    var tweetID:Int = -1
    
    func setRetweeted(_ isRetweeted:Bool){
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    func setFavorited(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
