//
//  ViewAddViewController.swift
//  Krishakah
//
//  Created by RichLabs on 07/12/20.
//

import UIKit

class ViewAddViewController: UIViewController {
    @IBOutlet weak var nutBtn:UIButton!
    @IBOutlet weak var spiceBtn:UIButton!
    @IBOutlet weak var oilBtn:UIButton!
    @IBOutlet weak var legumeBtn:UIButton!
    @IBOutlet weak var grainBtn:UIButton!
    @IBOutlet weak var vegetbleBtn:UIButton!
    @IBOutlet weak var fruitBtn:UIButton!
    @IBOutlet weak var moreBtn:UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nutBtnTapped(_sender:Any){
        let Vca = storyboard?.instantiateViewController(identifier: "FeedVC") as! FeedVC
        Vca.feedType = "nutpost"
        navigationController?.pushViewController(Vca, animated: true)
    }
    
    @IBAction func grainBtnTapped(_sender:Any){
        let Vca = storyboard?.instantiateViewController(identifier: "FeedVC") as! FeedVC
        Vca.feedType = "grainpost"
        navigationController?.pushViewController(Vca, animated: true)
    }
    
    @IBAction func spiceBtnTapped(_sender:Any){
        let Vca = storyboard?.instantiateViewController(identifier: "FeedVC") as! FeedVC
        Vca.feedType = "spicepost"
        navigationController?.pushViewController(Vca, animated: true)
    }
    @IBAction func oilBtnTapped(_sender:Any){
        let Vca = storyboard?.instantiateViewController(identifier: "FeedVC") as! FeedVC
        Vca.feedType = "oilpost"
        navigationController?.pushViewController(Vca, animated: true)
    }
    @IBAction func legumeBtnTapped(_sender:Any){
        let Vca = storyboard?.instantiateViewController(identifier: "FeedVC") as! FeedVC
        Vca.feedType = "legumepost"
        navigationController?.pushViewController(Vca, animated: true)
    }
    @IBAction func fruitBtnTapped(_sender:Any){
        let Vca = storyboard?.instantiateViewController(identifier: "FeedVC") as! FeedVC
        Vca.feedType = "fruitpost"
        navigationController?.pushViewController(Vca, animated: true)
    }
    @IBAction func moreBtnTapped(_sender:Any){
        let Vca = storyboard?.instantiateViewController(identifier: "FeedVC") as! FeedVC
        Vca.feedType = "morepost"
        navigationController?.pushViewController(Vca, animated: true)
    }
    @IBAction func vegetableBtnTapped(_sender:Any){
        let Vca = storyboard?.instantiateViewController(identifier: "FeedVC") as! FeedVC
        Vca.feedType = "vegetablepost"
        navigationController?.pushViewController(Vca, animated: true)
    }
}
