//
//  SearchVC.swift
//  Dacadoo
//
//  Created by Pajaziti Labinot on 14.5.24..
//

import UIKit

class SearchVC: UIViewController {
    let logoImageView       = UIImageView()
    let searchTextField     = DCDTextField()
    let searchButton        = DCDButton(backgroundColor: .systemGreen, title: "Get Photos")
    
    var isCountryTextField: Bool { return !searchTextField.text!.isEmpty }
    var logoImageViewTopConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(logoImageView, searchTextField, searchButton)
        configureLogoImageView()
        configureTextField()
        configureSearchButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
   private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushToListVC() {
        guard isCountryTextField else {
            presentDCDAlertOnMainThread(title: "Attention",
                                       message: "Please write something in field. We need to know what to look for 🙂.",
                                       buttonTitle: "Ok")
            return
            }
        searchTextField.resignFirstResponder()
        let photoDataProvider: PhotoDataProvider = NetworkManager.shared
          
          let itemListVC = SearchedListVC(username: searchTextField.text!, photoDataProvider: photoDataProvider)
          navigationController?.pushViewController(itemListVC, animated: true)
     }
    
    private func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        logoImageView.layer.cornerRadius = 100
        logoImageView.clipsToBounds = true

        let topConstraint: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraint)
        logoImageViewTopConstraint.isActive = true

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func configureTextField() {
        searchTextField.delegate = self
        searchTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSearchButton() {
        searchButton.addTarget(self, action: #selector(pushToListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToListVC()
        return true
    }
}
