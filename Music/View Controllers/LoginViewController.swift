//
//  LoginViewController.swift
//  Music
//
//  Created by Shoval Hazan on 08/07/2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func didTapLogin(_ sender: Any) {
        let email = emailTextField.text ?? .empty
        let passowrd = passwordTextField.text ?? .empty
        
        Auth.auth().createUser(withEmail: email, password: passowrd) { [weak self] _, error in
            
            guard let error = error else {
                self?.progressToHomeScreen()
                return
            }
            
            if error._code == AuthErrorCode.emailAlreadyInUse.rawValue {
                
                Auth.auth().signIn(withEmail: email, password: passowrd) { _, error in
                    
                    guard let error = error else {
                        self?.progressToHomeScreen()
                        return
                    }
                    self?.showErrorPrompt(withMessage: error.localizedDescription)
                }
            } else {
                self?.showErrorPrompt(withMessage: error.localizedDescription)
            }
        }
    }
    
    private func progressToHomeScreen() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        let homeViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "HomeViewController")
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    private func showErrorPrompt(withMessage message: String) {
        errorLabel.text = message
        errorLabel.shake()
    }
}
