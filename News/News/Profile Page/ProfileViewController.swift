//
//  ProfileViewController.swift
//  News
//
//  Created by Ceren Güneş on 17.09.2023.
//

import FirebaseAuth
import Firebase
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setProfilePic()
        retrieveData(key: "image")
        
        emailLabel.text = profileViewModel.getEmail()
    }
    
    func setProfilePic() {
        profileImageView.image = UIImage(systemName: "photo.circle.fill")
        profileImageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        profileImageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func saveImage(image: UIImage) {
        let imageData = image.pngData()! as NSData
        UserDefaults.standard.set(imageData, forKey: "image")
    }
    
    func retrieveData(key: String) {
        guard let data = UserDefaults.standard.value(forKey: "image") as? NSData else { return }
        let image = UIImage(data: data as Data)
        profileImageView.image = image
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
    
    @IBAction func darkModeButtonTapped(_ sender: UISwitch) {
        darkModeLabel.text = profileViewModel.darkModeButtonTapped(sender)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        profileImageView.image = image
        saveImage(image: image)
        self.dismiss(animated: true)
    }
}
