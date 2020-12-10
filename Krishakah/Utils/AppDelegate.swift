//
//  AppDelegate.swift
//  Krishakah
//
//  Created by RichLabs on 26/11/20.
//


import UIKit
import Firebase
import UserNotifications
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static var deviceModelName = String()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("Device model name: ",UIDevice.modelName)
        AppDelegate.deviceModelName = UIDevice.modelName
        
        IQKeyboardManager.shared.enable = true
        
        FirebaseApp.configure()
        
        return true
    }
}
