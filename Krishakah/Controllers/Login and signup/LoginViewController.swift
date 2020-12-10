//
//  LoginViewController.swift
//  Krishakah
//
//  Created by RichLabs on 26/11/20.
//

import UIKit
import AVKit
import AVFoundation
import Alamofire
import MBProgressHUD
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    //gifview
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var splashView: UIView!
//splashTimer
    var timer = Timer()
    var count = 0
    
//viewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        gifView.loadGif(name: "splashScreen")
        count = 1
        timer = Timer.scheduledTimer(timeInterval: 2, target: self,selector: #selector(timeFunction), userInfo: nil, repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            if UserDefaults.standard.string(forKey: UserDetails.userEmail) != nil
            {
                self.navHomeTabBarVC()
            }
        }
    }
    
    //MARK:- viewWillAppear()
    override func viewWillAppear(_ animated: Bool)
    {
        
    }
    
    //splashTimerFunction
    @objc func timeFunction()
    {
         count = count-1
        if count == 0
        {
        timer.invalidate()
        splashView.isHidden=true
        }
     }
    
    //MARK:- on login btn tap
    @IBAction func onLoginBtnTap(_ sender: UIButton)
    {
        if emailTF.text == ""
        {
            showToast(message: "Please enter Email ID.")
        }
        else if passwordTF.text == ""
        {
            showToast(message: "Please enter Password.")
        }
        else
        {
            validateLogin()
        }
    }
    
    //MARK: - on signup btn tap
    @IBAction func onRegisterBtnTap(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
        
    //MARK:- navLocationVC()
    func navHomeTabBarVC()
    {
        let locationVC = storyboard?.instantiateViewController(withIdentifier: "HomeTabBarController") as! HomeTabBarController
        navigationController?.pushViewController(locationVC, animated: true)
    }
    //MARK:- validateLogin()
    func  validateLogin(){
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if emailTF.text != nil && passwordTF.text != nil {
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!, completion: { [self] (user, error) in
                if error != nil
                {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    showToast(message: error!.localizedDescription)
                }
                else
                {
                    let email = self.emailTF.text!
                    UserDefaults.standard.set(email, forKey: UserDetails.userEmail)
                    MBProgressHUD.hide(for: self.view, animated: true)
                    navHomeTabBarVC()
                }
            })
            
        }else{
        
            showToast(message: "Please enter your 'Email Id' and 'Password'")
        
    }
    
}
}
