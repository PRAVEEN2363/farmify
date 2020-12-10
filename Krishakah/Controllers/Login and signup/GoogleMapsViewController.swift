//
//  GoogleMapsViewController.swift
//  Krishakah
//
//  Created by RichLabs on 27/11/20.
//

import UIKit

class GoogleMapsViewController: UIViewController {
    @IBOutlet weak var confirmLocationBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onConfirmLocationBtnTap(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeTabBarController")  as! HomeTabBarController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}
