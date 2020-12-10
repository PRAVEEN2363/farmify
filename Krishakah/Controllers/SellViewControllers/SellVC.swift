//
//  SellVC.swift
//  Krishakah
//
//  Created by RichLabs on 07/12/20.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import MBProgressHUD

class SellVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var itemName:UITextField!
    @IBOutlet weak var itemPrice:UITextField!
    @IBOutlet weak var itemImage:UIImageView!
    @IBOutlet weak var itemDetails:UITextField!
    @IBOutlet weak var ownerName:UITextField!
    @IBOutlet weak var mobileNumber:UITextField!
    
    @IBOutlet weak var bgImageView: UIImageView!
    //post Button
    @IBOutlet weak var postAddBtn:UIButton!
    var uuid = NSUUID().uuidString
    
    var sellType = String()
    
    //MARK:- viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemImage.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        itemImage.addGestureRecognizer(recognizer)
    }
    
    //MARK:- viewWillAppear()
    override func viewWillAppear(_ animated: Bool)
    {
        if sellType == "nutpost"
        {
            bgImageView.image = UIImage(named: "nutVcBg")
        }
        else if sellType == "grainpost"
        {
            bgImageView.image = UIImage(named: "grainsVcBg")
        }
        else if sellType == "legumepost"
        {
            bgImageView.image = UIImage(named: "legumesVcBg")
        }
        else if sellType == "spicepost"
        {
            bgImageView.image = UIImage(named: "spicesVcBg")
        }
        else if sellType == "oilpost"
        {
            bgImageView.image = UIImage(named: "oilsVcBg")
        }
        else if sellType == "fruitpost"
        {
            bgImageView.image = UIImage(named: "fruitsVcBg")
        }
        else if sellType == "vegetablepost"
        {
            bgImageView.image = UIImage(named: "vegetablesVcBg")
        }
        else if sellType == "extrapost"
        {
            bgImageView.image = UIImage(named: "moreVcBg")
        }
    }
    
    //MARK:- postBtnClicked()
    @IBAction func postBtnClicked(_ sender: Any){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let mediaFolder = Storage.storage().reference().child(sellType)
        if let data = itemImage.image!.jpegData(compressionQuality: 0.5){
            
            mediaFolder.child("\(uuid).jpg").putData(data,metadata: nil,completion: {(metadata,error)in
                 if error != nil {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.showToast(message: error!.localizedDescription)
                 }else{
                    let imageURL = metadata?.downloadURL()?.absoluteString
                    let post = ["itemimage" : imageURL!,"postedby" : Auth.auth().currentUser!.email!, "uuid" : self.uuid, "itemname": self.itemName.text, "itemprice":self.itemPrice.text,"ownername":self.ownerName.text,"mobilenumber":self.mobileNumber.text,"itemdetails": self.itemDetails.text as Any] as [String:Any]
                    Database.database().reference().child(self.sellType).child((Auth.auth().currentUser?.uid)!).child("post").childByAutoId().setValue(post)
                    
                    self.itemImage.image = UIImage(named: "phoneUploadImage")
                    self.itemName.text = ""
                    self.itemPrice.text = ""
                    self.itemDetails.text = ""
                    self.ownerName.text = ""
                    self.mobileNumber.text = ""
                    self.tabBarController?.selectedIndex = 0
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.showToast(message: "Posted Successfully")
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.5)
                    {
                        self.navHomeTabBar()
                    }
                }
            })
        }
    }
    
    @objc func selectImage(){
     let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        itemImage.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    //navBackFunction
    func navHomeTabBar() {
        let vc = storyboard?.instantiateViewController(identifier: "HomeTabBarController") as! HomeTabBarController
        navigationController?.pushViewController(vc, animated: true)
    }
}
