//
//  OnboardingViewModel.swift
//  News
//
//  Created by Ceren Güneş on 20.09.2023.
//

import UIKit

final class OnboardingViewModel {
    
    var onboardingPageControl: UIPageControl!
    
    let animations = ["world", "newspaper", "phone"]
    let titles = ["Welcome to the News!", "Stay up to date with the latest news wherever you are!", "Let's get started!"]
    var currentPage =  0 {
        didSet {
            onboardingPageControl.currentPage = currentPage
        }
    }
    var safeAnimations = [String]()
}
