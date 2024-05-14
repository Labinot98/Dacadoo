//
//  UIViewController+Ext.swift
//  Dacadoo
//
//  Created by Pajaziti Labinot on 14.5.24..
//

import UIKit

extension UIViewController {
    
   func presentDCDAlertOnMainThread(title: String, message: String, buttonTitle: String) {
       DispatchQueue.main.async {
           let alertVC = DCDAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
           alertVC.modalPresentationStyle    = .overFullScreen
           alertVC.modalTransitionStyle      = .crossDissolve
           self.present(alertVC, animated: true)
       }
    }
}
