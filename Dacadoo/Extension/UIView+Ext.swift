//
//  UIView+Ext.swift
//  Dacadoo
//
//  Created by Pajaziti Labinot on 14.5.24..
//

import UIKit

extension UIView {
    func addSubview(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
