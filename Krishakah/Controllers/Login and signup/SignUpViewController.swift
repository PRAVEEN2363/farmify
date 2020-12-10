//
//  SignUpViewController.swift
//  Krishakah
//
//  Created by RichLabs on 26/11/20.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var mobileNumber = String()
    //MARK:- viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: - signUpButtonAction()
    @IBAction func signUpButtonAction(_ sender: UIButton)
    {
        if nameTextField.text == ""
        {
            showToast(message: "Please enter User Name!")
        }
        else if emailTextField.text == ""
        {
            showToast(message: "Please enter EmailID!")
        }
        else if passwordTextField.text == ""
        {
            showToast(message: "Please enter Password")
        }
        else
        {
            if passwordTextField.text!.count < 8
            {
                showToast(message: "Password must atleast 8 letters.")
            }
            else
            {
                validateSignUp()
            }
        }
    }
    
    //MARK: - loginButtonAction()
    @IBAction func loginButtonAction(_ sender: UIButton)
    {
        navLogin()
    }
    
    //MARK: - changeNumberAction()
    @IBAction func changeNumberAction(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- navLogin()
    func navLogin()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- navSetAddress()
    func navSetAddress()
    {
        let setDeliveryVC = storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
        navigationController?.pushViewController(setDeliveryVC, animated: true)
    }
    
    //MARK:- validateSignUp()
    func validateSignUp(){
        if emailTextField.text != nil && passwordTextField.text != nil && nameTextField.text != nil{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if error != nil {
                    self.showToast(message: "\(error?.localizedDescription)")
                }
                else
                {
                    let email = self.emailTextField.text!
                    UserDefaults.standard.set(email, forKey: UserDetails.userEmail)
                    let username = self.nameTextField.text!
                    UserDefaults.standard.set(username,forKey: UserDetails.userName)
                    let mobilenumber = self.mobileNumber
                    UserDefaults.standard.set(mobilenumber,forKey: UserDetails.mobileNumber)
                    self.navSetAddress()
                }
        })
        
    }else{
        showToast(message: "no input found")
    }
    
}
}
