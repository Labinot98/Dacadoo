//
//  DCDAvatarImageView.swift
//  Dacadoo
//
//  Created by Pajaziti Labinot on 14.5.24..
//

import UIKit

class DCDImageView: UIImageView {
    let cache = NetworkManager.shared.cache
    let placeHolderImage = Images.placeHolder

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func configure() {
         layer.cornerRadius = 10
         clipsToBounds = true
         image = placeHolderImage
         translatesAutoresizingMaskIntoConstraints = false
                 
         contentMode = .scaleAspectFill
         clipsToBounds = true
    }
}
