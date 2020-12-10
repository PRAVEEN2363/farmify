//
//  RegisterViewController.swift
//  Krishakah
//
//  Created by RichLabs on 26/11/20.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var mobileNumberTF: UITextField!
     //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - continue btn action
    @IBAction func onContinueBtnTap(_ sender: Any)
    {
        if mobileNumberTF.text == ""
        {
            showToast(message: "Please enter Mobile Number!")
        }
        else
        {
            navOtpVC()
        }
    }
    //MARK:- navOtpVC()
    func navOtpVC()
    {
        let otpVC =  storyboard?.instantiateViewController(withIdentifier: "OtpViewController") as! OtpViewController
        otpVC.mobileNumber = mobileNumberTF.text!
        self.navigationController?.pushViewController(otpVC, animated: true)
    }

}
