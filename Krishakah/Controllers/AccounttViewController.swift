//
//  AccounttViewController.swift
//  Krishakah
//
//  Created by RichLabs on 30/11/20.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import Kingfisher

class AccounttViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var logoutBtn:UIButton!
    @IBOutlet weak var profileImage:UIImageView!
    @IBOutlet weak var editInfoBtn:UIButton!
    @IBOutlet weak var uploadProfilePic:UIImageView!
    @IBOutlet weak var saveChangesBtn:UIButton!
    @IBOutlet weak var editInfoView:UIView!    
    @IBOutlet weak var editEmailBtn:UIButton!
    @IBOutlet weak var editMobileNUmbner:UIButton!
    @IBOutlet weak var emaillabel:UILabel!
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var numberLabel:UILabel!
    var pictureList = [postModel]()
    var uuid = NSUUID().uuidString
    var email = UserDefaults.standard.string(forKey: UserDetails.userEmail)
    let name = UserDefaults.standard.string(forKey: UserDetails.userName)
    let number = UserDefaults.standard.string(forKey: UserDetails.mobileNumber)
    override func viewDidLoad() {
        super.viewDidLoad()
        editInfoView.isHidden = true
        emaillabel.text = email
        nameLabel.text = name
        numberLabel.text = number
        retreivePicture()
        profileImage.layer.cornerRadius = profileImage.bounds.width/2
        profileImage.layer.masksToBounds = true
    }
    
    @IBAction func logOutClicked(_ sender: Any)
    {
        UserDefaults.standard.removeObject(forKey: UserDetails.userEmail)
        navSignIn()
    }
    //MARK:- navSignIn()
    func navSignIn()
    {
        let signInVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as!LoginViewController
        navigationController?.pushViewController(signInVC, animated: true)
    }
    //EditInfoButton Action
    @IBAction func editInfoBtnTapped(_sender:UIButton)
    {
        editInfoView.isHidden = false
        uploadProfilePic.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        uploadProfilePic.addGestureRecognizer(recognizer)
    }
    @objc func selectImage(){
     let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadProfilePic.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    //saveChangesButton
    @IBAction func saveChangesBtnTapped(_sender:UIButton){
        uploadPicture()
        editInfoView.isHidden = true
    }
    //SavingProfilePicture
    func uploadPicture(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let mediaFolder = Storage.storage().reference().child("profilepicture")
        if let data = uploadProfilePic.image!.jpegData(compressionQuality: 0.5){
            mediaFolder.child("\(uid).jpg").putData(data,metadata: nil,completion: {(metadata,error)in
                 if error != nil {
                    self.showToast(message: error!.localizedDescription)
                 }else{
                    let imageURL = metadata?.downloadURL()?.absoluteString
                    let post = ["updatedpicture" : imageURL! as Any] as [String:Any]
                    Database.database().reference().child(uid).child((Auth.auth().currentUser?.uid)!).child(uid).childByAutoId().setValue(post)
                    self.uploadProfilePic.image = UIImage(named: "uploadImage")
                    }
                }
    )}
    }
    //RetreiveingProfilePicture
    func retreivePicture(){
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child(uid!).observe(DataEventType.childAdded) {(snapshot) in
            let values = snapshot.value! as! NSDictionary
            let post = values[uid!] as! NSDictionary
            let postIDs = post.allKeys
            for id in postIDs{
                let singlePost = post[id] as! NSDictionary
                let profilePicture = singlePost["updatedpicture"] as! String
                let currentPicture = postModel.init(profilePicture: profilePicture)
                self.pictureList.append(currentPicture)
                let imageUrl = URL(string: currentPicture.profilePicture)!
                self.profileImage.kf.setImage(with: imageUrl)
            }
        }
    }
}

class postModel
{
    var profilePicture = String()
    init(profilePicture:String) {
        self.profilePicture = profilePicture
    }
}
