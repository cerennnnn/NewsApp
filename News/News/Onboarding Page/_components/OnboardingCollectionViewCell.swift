//
//  OnboardingCollectionViewCell.swift
//  News
//
//  Created by Ceren Güneş on 17.09.2023.
//

import Lottie
import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var onboardingView: LottieAnimationView!
    @IBOutlet weak var onboardingLabel: UILabel!
    
    static let identifier = String(String(describing: OnboardingCollectionViewCell.self))
    
}
