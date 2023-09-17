//
//  UITextField.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import UIKit

extension UITextField {
    
    func setupLeftSideImage(with systemIcon: String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 22, height: 20))
        imageView.image = UIImage(systemName: systemIcon)
        imageView.contentMode = .scaleAspectFit
        imageView.image?.withRenderingMode(.alwaysOriginal)
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageViewContainerView.addSubview(imageView)
        leftView = imageViewContainerView
        leftViewMode = .always
        self.tintColor = .darkGray
    }
}
