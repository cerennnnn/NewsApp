//
//  LoginViewController.swift
//  News
//
//  Created by Ceren Güneş on 17.09.2023.
//

import UIKit
import Lottie
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupAnimation()
        setupTextFields()
        generateActivityIndicator()
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
    }
    
    private func setupAnimation() {
        guard let myFile = Bundle.main.path(forResource: "login", ofType: "json") else {
            print("error")
            return
        }
        animationView.animation = LottieAnimation.filepath(myFile)
        animationView.loopMode = .autoReverse
        animationView.play()
    }
    
    private func setupTextFields() {
        emailTextField.setupLeftSideImage(with: "envelope.fill")
        passwordTextField.setupLeftSideImage(with: "lock.fill")
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignUpViewController", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            
            activityIndicator.startAnimating()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let navBar = UINavigationController(rootViewController: vc)
                navBar.modalPresentationStyle = .fullScreen
                self.present(navBar, animated: true)
                self.activityIndicator.stopAnimating()
            }

        }
        
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
                  

        if let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
            if let email = emailTextField.text, let password = passwordTextField.text{
                //            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                //                if let e = error {
                //                    self.handleError(e as! AuthErrorCode)
                //                } else {
                lottieAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let navBar = UINavigationController(rootViewController: vc)
                    navBar.modalPresentationStyle = .fullScreen
                    self.present(navBar, animated: true)
                    UserDefaults.standard.hasOnboarded = true
                    //                    }
                    //                }
                }
            }
        }
    }

    func generateActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
    }
    
    func lottieAnimation() {
        let animationView = LottieAnimationView(name: "tick.json")
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 250)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        animationView.play()
        animationView.loopMode = .autoReverse
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            animationView.stop()
        }
    }
}
