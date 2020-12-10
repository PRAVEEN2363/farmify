//
//  OtpViewController.swift
//  Krishakah
//
//  Created by RichLabs on 26/11/20.
//

import UIKit
import Alamofire
import FirebaseAuth
import MBProgressHUD

class OtpViewController: UIViewController {
    @IBOutlet weak var secondsRemainingLabel: UILabel!
    
    @IBOutlet weak var cOneOTPField: UITextField!
    @IBOutlet weak var cTwoOTPField: UITextField!
    @IBOutlet weak var cThreeOTPField: UITextField!
    @IBOutlet weak var cFourOTPField: UITextField!
    @IBOutlet weak var cFiveOTPField: UITextField!
    @IBOutlet weak var cSixOTPField: UITextField!
    
    @IBOutlet weak var cResendCodeButton: UIButton!
    @IBOutlet weak var cVerifyCodeButton: UIButton!
    @IBOutlet weak var cChangeNumberButton: UIButton!
    
    var otpSend = Int()
    var otpEntred = Int()
    var mobileNumber = String()
    
    var counter = 60
    var timer = Timer()
    
    //MARK:- viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cOneOTPField.delegate = self
        cTwoOTPField.delegate = self
        cThreeOTPField.delegate = self
        cFourOTPField.delegate = self
        cFiveOTPField.delegate = self
        cSixOTPField.delegate = self
        
        cOneOTPField.setBottomBorder()
        cTwoOTPField.setBottomBorder()
        cThreeOTPField.setBottomBorder()
        cFourOTPField.setBottomBorder()
        cFiveOTPField.setBottomBorder()
        cSixOTPField.setBottomBorder()
        
        cOneOTPField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        cTwoOTPField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        cThreeOTPField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        cFourOTPField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        cFiveOTPField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        cSixOTPField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        secondsRemainingLabel.isHidden = true
        self.sendFirebaseOTP()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+60) {
            self.cResendCodeButton.isEnabled = true
        }
    }
    
    //MARK:- viewWillAppear()
    override func viewWillAppear(_ animated: Bool)
    {
//        verificationCodeInfoLabel.text = "On +91\(mobileNumber)"
        self.cResendCodeButton.isEnabled = false
        cOneOTPField.becomeFirstResponder()
    }
    
    //MARK:- verifyButtonAction()
    @IBAction func verifyButtonAction(_ sender: UIButton)
    {
        if cOneOTPField.text == "" || cTwoOTPField.text == "" || cThreeOTPField.text == "" || cFourOTPField.text == "" || cFiveOTPField.text == "" || cSixOTPField.text == ""
        {
            showToast(message: "Please enter otp!")
        }
        else
        {
            otpFirebaseValidation()
        }
    }
    
    //MARK:- resendButtonAction()
    @IBAction func resendButtonAction(_ sender: UIButton)
    {
        secondsRemainingLabel.isHidden = true
        self.sendFirebaseOTP()
        self.cResendCodeButton.isEnabled = false
        counter = 60
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now()+30) {
            self.cResendCodeButton.isEnabled = true
        }
    }
    
    //MARK:- changeNumberButtonAction()
    @IBAction func changeNumberButtonAction(_ sender: UIButton)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func timerAction() {
        if counter > 0
        {
            counter -= 1
            secondsRemainingLabel.text = "Seconds Remaining : \(counter)"
        }
        else
        {
            secondsRemainingLabel.text = "Seconds Remaining : \(counter)"
            timer.invalidate()
        }
    }
    
    //MARK:- ObjC textFieldDidChage()
    @objc func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        if  text?.count == 1
        {
            switch textField
            {
            case cOneOTPField:
                cTwoOTPField.becomeFirstResponder()
            case cTwoOTPField:
                cThreeOTPField.becomeFirstResponder()
            case cThreeOTPField:
                cFourOTPField.becomeFirstResponder()
            case cFourOTPField:
                cFiveOTPField.becomeFirstResponder()
            case cFiveOTPField:
                cSixOTPField.becomeFirstResponder()
            case cSixOTPField:
                cSixOTPField.resignFirstResponder()
                self.otpFirebaseValidation()
            default:
                break
            }
        }
    }
    
    //MARK:- navSignUpVC()
    func navSignUpVC()
    {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        signUpVC.mobileNumber = self.mobileNumber
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    //MARK:- sendFirebaseOTP()
    func sendFirebaseOTP()
    {
        let otpMobileNumber = "+91\(mobileNumber)"
        PhoneAuthProvider.provider().verifyPhoneNumber(otpMobileNumber, uiDelegate: nil) { (verificationID, error) in
            if error == nil
            {
                UserDefaults.standard.set(verificationID, forKey: UserDetails.verificationID)
            }
            else
            {
                print("Send OTP Error : ",error!.localizedDescription)
                self.showToast(message: error!.localizedDescription)
            }
        }
    }
    
    
    //MARK:- otpFirebaseValidation()
    func otpFirebaseValidation()
    {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let verificationCode = "\(cOneOTPField.text!)\(cTwoOTPField.text!)\(cThreeOTPField.text!)\(cFourOTPField.text!)\(cFiveOTPField.text!)\(cSixOTPField.text!)"
        guard let verificationID = UserDefaults.standard.string(forKey: UserDetails.verificationID) else { return }
        print("Verification code: ", verificationCode)
        print("Verification Id: ", verificationID)
        let credential = PhoneAuthProvider.provider().credential(
               withVerificationID: verificationID,
               verificationCode: verificationCode)

        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error == nil
            {
                MBProgressHUD.hide(for: self.view, animated: true)
                UserDefaults.standard.set(self.mobileNumber, forKey: UserDetails.mobileNumber)
                self.navSignUpVC()
            }
            else
            {
                print("SignIn OTP Error: ",error!.localizedDescription)
                MBProgressHUD.hide(for: self.view, animated: true)
                self.showToast(message: "Wrong OTP!")
            }
        }
    }
}

//MARK:- TextFieldDelegates
extension OtpViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

//MARK:- TaxtFieldUnderLine
extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(named: "btnClr")?.cgColor//UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
