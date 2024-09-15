//
//  SignUpViewController.swift
//  TodoApp
//
//  Created by doniyor normuxammedov on 01/03/24.
//

import UIKit
import FirebaseAuth
import Lottie
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signupbutton: UIButton!
    
//    var animation: LottieAnimationView?
    
    @IBOutlet weak var animationViewSignup: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationViewSignup.loopMode = .loop
        animationViewSignup.play()
        signupbutton.layer.cornerRadius = 18.0
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        if let email = emailTF.text, let password = passwordTF.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "SignUpToAllListvc", sender: self)
                }
            }
        }
    }
}
