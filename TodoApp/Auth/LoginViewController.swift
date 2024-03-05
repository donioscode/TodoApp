//
//  LoginViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 01/03/24.
//

import UIKit
import FirebaseAuth
import Lottie
class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBOutlet weak var loginbutton: UIButton!
    
    @IBOutlet weak var forgotpassword: UILabel!
    
    @IBOutlet weak var animationviewlogin: LottieAnimationView!
    
//    var animation: LottieAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        animationviewlogin.loopMode = .loop
        animationviewlogin?.play()
        loginbutton.layer.cornerRadius = 18.0
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        if let email = emailTF.text,let password = passwordTF.text{
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let e = error{
                    print(e)
                }else{
                    self.performSegue(withIdentifier: "LoginToAllListvc", sender: self)
                }
            }
        }
    }
}
