//
//  PhotoDetailVC.swift
//  Dacadoo
//
//  Created by Pajaziti Labinot on 14.5.24..
//

import UIKit

class PhotoDetailVC: DCDDataLoadingVC {
    
    var photo: Photo!
    private let imageView        = DCDImageView(frame: .zero)
    private let descriptionLabel = DCDTitleLabel(textAlignment: .center, fontSize: 18)

    init(photo: Photo) {
        super.init(nibName: nil, bundle: nil)
        self.photo = photo
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureDescriptionLabel()
        configureImageView()
        loadImage()
    }

    private func configureDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text          = photo.altDescription
        descriptionLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func configureImageView() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func loadImage() {
        showLoadingView()
        NetworkManager.shared.downloadImage(from: photo.urls.full) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.dismissLoadingView()
                self.imageView.image = image
            }
        }
    }
}
