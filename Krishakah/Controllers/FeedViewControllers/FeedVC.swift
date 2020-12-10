//
//  FeedVC.swift
//  Krishakah
//
//  Created by RichLabs on 06/12/20.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import Kingfisher

class FeedVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var postsList = [PostModel]()
    
    var feedType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromServer()
    }
    
    //Retreiveing Data from database
    func  getDataFromServer() {
        Database.database().reference().child(feedType).observe(DataEventType.childAdded) {(snapshot) in
            let values = snapshot.value! as! NSDictionary
            let post = values["post"] as! NSDictionary
            let postIDs = post.allKeys
            for id in postIDs{
                
                let singlePost = post[id] as! NSDictionary
                
                let itemName = singlePost["itemname"] as! String
                let itemPrice = singlePost["itemprice"] as! String
                let itemImage = singlePost["itemimage"] as! String
                let itemDetails = singlePost["itemdetails"] as! String
                let ownerName = singlePost["ownername"] as! String
                let mobileNumber = singlePost["mobilenumber"] as! String
                
                let currentPost = PostModel.init(itemName: itemName, itemPrice: itemPrice, itemImage: itemImage, itemDetails: itemDetails,ownerName:ownerName,mobileNumber: mobileNumber)
                
                self.postsList.append(currentPost)
            }
            self.tableView.reloadData()
        }
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return postsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LegumeFeedViewCell", for:indexPath) as! LegumeFeedViewCell
        
        let currentPost = postsList[indexPath.row]
        cell.contactButtonDelegate = self
        cell.itemName.text = currentPost.itemName
        cell.itemPrice.text = "₹ \(currentPost.itemPrice)"
        let imageUrl = URL(string: currentPost.itemImage)!
        cell.itemImage.kf.setImage(with: imageUrl)
        cell.itemDetails.text = currentPost.itemDetails
        cell.nameLabel.text = "Posted by \(currentPost.ownerName)"
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 600
        
    }
}

//MARK:- ContactButtonDelegates
extension FeedVC: FeedCellProtocol
{
    func contactButtonClicked(tableCell: UITableViewCell)
    {
        let selectedCellId = (tableView.indexPath(for: tableCell)?.row)!
        let currentPost = postsList[selectedCellId]
        let mobileNumber = currentPost.mobileNumber
        if let url = URL(string: "tel://\(mobileNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

//MARK:- PostModel Class
class PostModel
{
    var itemName = String()
    var itemPrice = String()
    var itemImage = String()
    var itemDetails = String()
    var ownerName = String()
    var mobileNumber = String()
    
    init(itemName: String, itemPrice: String, itemImage: String, itemDetails: String,ownerName:String,mobileNumber:String)
    {
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.itemImage = itemImage
        self.itemDetails = itemDetails
        self.ownerName = ownerName
        self.mobileNumber = mobileNumber
    }
}

