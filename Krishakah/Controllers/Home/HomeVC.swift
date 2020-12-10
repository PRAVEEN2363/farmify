//
//  HomeVC.swift
//  Krishakah
//
//  Created by RichLabs on 28/11/20.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var addsBtn:UIButton!
    @IBOutlet weak var chatsBtn:UIButton!
    @IBOutlet weak var favouritesBtn:UIButton!
    @IBOutlet weak var welcomeLabel:UILabel!
 
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let name = UserDefaults.standard.string(forKey: UserDetails.userName)
        welcomeLabel.text = "Welcome \(name ?? "")."
    }
    
    @IBAction func addsBtnTapped(_sender:Any){
        let Vca = storyboard?.instantiateViewController(identifier: "ViewAddViewController") as! ViewAddViewController
        navigationController?.pushViewController(Vca, animated: true)
    }
    @IBAction func chatBtnTapped(_sender:Any){
        let alert = UIAlertController(title: "", message: "You have no active chats", preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func favouritesBtnTapped(_sender:Any){
        let alert = UIAlertController(title: "", message: "You haven't saved any ads yet", preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}
