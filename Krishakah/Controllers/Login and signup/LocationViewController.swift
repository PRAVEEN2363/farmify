//
//  LocationViewController.swift
//  Krishakah
//
//  Created by RichLabs on 26/11/20.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var setLocationBtn: UIButton!
    
    //MARK:- viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - set delivery btn action
    @IBAction func onSetLocationBtnTap(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GoogleMapsViewController") as! GoogleMapsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
