//
//  ViewController.swift
//  dev-showcase
//
//  Created by IG on 2016. 2. 11..
//  Copyright © 2016년 ansugeun.k. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func fbBtnPressed(sender:UIButton!){
//        let facebookLogin = FBSDKLoginManager()
//        
//        
//        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult : FBSDKLoginManagerLoginResult!,facebookError :  NSError!) -> Void in
//            if facebookError != nil{
//                print("Facebook Login failed. Error \(facebookError)")
//            }else{
//                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
//                print("로긴 성공\(accessToken)")
//            }
//        }
//    }
//        let ref = Firebase(url: "https://<YOUR-FIREBASE-APP>.firebaseio.com")
        let facebookLogin = FBSDKLoginManager()

        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self ) { (facebookResult:FBSDKLoginManagerLoginResult!, facebookError:NSError!) -> Void in
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else if facebookResult.isCancelled {
                print("Facebook login was cancelled.")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("로긴 성공\(accessToken)")
                
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { (err:NSError!, authData) -> Void in
                    
                    if err != nil {
                        print("Login Failed \(err.debugDescription)")
                    }else {
                        print("Logged In! \(authData)")
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier("loggedIn", sender: nil)
                    }
                })
                
            }
        }
        
        
      
    }
}

