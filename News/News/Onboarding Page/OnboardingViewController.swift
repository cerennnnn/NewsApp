//
//  OnboardingViewController.swift
//  News
//
//  Created by Ceren Güneş on 17.09.2023.
//

import Lottie
import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var onboardingPageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    let animations = ["world", "newspaper", "phone"]
    let titles = ["Welcome to the News!", "Stay up to date with the latest news wherever you are!", "Let's get started!"]
    var currentPage =  0 {
        didSet {
            onboardingPageControl.currentPage = currentPage
        }
    }
    var safeAnimations = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupOnboardingCollectionView()
        getAnimations()
    }
    
    private func setupOnboardingCollectionView() {
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
    }
    
    private func getAnimations() {
        for item in animations {
            guard let myFile = Bundle.main.path(forResource: item, ofType: "json") else {
                print("error")
                return
            }
            safeAnimations.append(myFile)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentPage == safeAnimations.count - 1 {
            UserDefaults.standard.hasOnboarded = true
            goToLoginViewController()
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skipButtonTapped))
    }
    
    @objc func skipButtonTapped() {
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    private func goToLoginViewController() {
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return safeAnimations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        let selectedTitle = titles[indexPath.row]
        let selectedImage = safeAnimations[indexPath.row]
        
        cell.onboardingLabel.text = selectedTitle
        cell.onboardingView.animation = LottieAnimation.filepath(selectedImage)
        
        cell.onboardingView.loopMode = .autoReverse
        cell.onboardingView.play()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / pageWidth)
    }
}
