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

    
    @IBOutlet weak var emailField:UITextField!
    @IBOutlet weak var passwordField:UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
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
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                })
                
            }
        }

    }
    
    @IBAction func attemptLogin(sender:UIButton!){
        
        
        if let email = emailField.text where email != "" ,let pwd = passwordField.text where pwd != ""{
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { (err, authData) -> Void in
                if err != nil {
                    print(err)
                    
                    if err.code == STATUS_ACCOUNT_NONEXIST {
                        DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { (error, result) -> Void in
                            
                            
                            if error != nil {
                                self.showErrorAlert("계정 생성 불가", msg: "다른 계정으로 시도해보세요")
                            }  else {
                                NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                                
                                DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: nil)
                                
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                            }
                        })
                    } else {
                        self.showErrorAlert("로그인 불가", msg: "이메일과 패스워드 확인 부탁드립니다.")
                    }
                } else {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
            })
            
            
        }else {
            showErrorAlert("이메일 과 패스워드 필요함",msg: "로그인하기위해선 이메일과 패스워드가 필요하다")
        }
    }
    
    func showErrorAlert(title:String, msg:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
}

