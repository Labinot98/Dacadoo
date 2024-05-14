//
//  DCDAlertContainerView.swift
//  Dacadoo
//
//  Created by Pajaziti Labinot on 14.5.24..
//

import UIKit

class DCDAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor        = .systemBackground
        layer.cornerRadius     = 16
        layer.borderWidth      = 2
        layer.borderColor      = UIColor.white.cgColor
    }
}
