//
//  ViewController.swift
//  fbLogin3.0
//
//  Created by Rails on 16/07/19.
//  Copyright © 2019 gammastack. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit
import FBSDKCoreKit
import FacebookLogin

class ViewController: UIViewController {

    @IBOutlet var loginWithFacebookLabel: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginWithFacebookLabel.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [ .publicProfile, .email ], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!", accessToken.userID, accessToken.tokenString, accessToken)
                
                let req = GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: accessToken.tokenString, version: nil, httpMethod: HTTPMethod(rawValue: "GET"))
                
                req.start(completionHandler: { (connection, result, error) in
                    if(error == nil) {
                        print("result \(result ?? "not Available")")
                    } else {
                        print("error \(error ?? "not avilable" as! Error)")
                    }
                })
            }
        }
    }
}
