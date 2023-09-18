//
//  SignUpViewController.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import UIKit
import Lottie
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupAnimation()
        setupTextFields()
        
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
    }
    
    private func setupAnimation() {
        let greeting = LottieAnimationView(name: "greeting.json")
        
        animationView.animation = greeting.animation
        animationView.loopMode = .autoReverse
        animationView.play()
    }
    
    private func setupTextFields() {
        usernameTextField.setupLeftSideImage(with: "person.fill")
        emailTextField.setupLeftSideImage(with: "envelope.fill")
        passwordTextField.setupLeftSideImage(with: "lock.fill")
        confirmPasswordTextField.setupLeftSideImage(with: "lock.fill")
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        if let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text {
            
//            UserDefaults.standard.set(username, forKey: "username")
//            UserDefaults.standard.set(email, forKey: "email")
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.handleError(e as! AuthErrorCode)
                } else {
                    if confirmPassword != password {
                        let alert = UIAlertController(title: "Oops!", message: "Passwords do not match.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .default))
                        self.present(alert, animated: true)
                    } else {
                        self.showAlert()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                            self.navigationController?.pushViewController(vc,
//                            animated: true)
                            let navBar = UINavigationController(rootViewController: vc)
                            navBar.modalPresentationStyle = .fullScreen
                            self.present(navBar, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigationController?.pushViewController(vc,
            animated: true)
        }
    }
    
    private func generateActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Registration successfull!", message: "Please sign in.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        self.present(alert, animated: true)
    }
}
