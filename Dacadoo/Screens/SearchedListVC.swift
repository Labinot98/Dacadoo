//
//  SearchedListVC.swift
//  Dacadoo
//
//  Created by Pajaziti Labinot on 14.5.24..
//

import UIKit

class SearchedListVC: DCDDataLoadingVC {
    var photos: [Photo]      = []
    var username: String!
    private let tableView    = UITableView()
    private var tableViewManager: TableViewManager<Photo, PhotoCell>!
    private let photoDataProvider: PhotoDataProvider

    init(username: String, photoDataProvider: PhotoDataProvider) {
          self.photoDataProvider = photoDataProvider
          super.init(nibName: nil, bundle: nil)
          self.username          = username
          title                  = username
      }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        loadPhotos()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(PhotoCell.self, forCellReuseIdentifier: String(describing: PhotoCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableViewManager = TableViewManager(
            items: photos,
            configureCell: { (cell, photo) in
                cell.set(photo: photo)
                cell.selectionStyle = .none
            },
            didSelectItem: { [weak self] photo in
                let detailVC = PhotoDetailVC(photo: photo)
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }
        )

        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
    }
    private func loadPhotos() {
            showLoadingView()
            photoDataProvider.searchPhotos(for: username) { [weak self] result in
                guard let self = self else { return }
                self.dismissLoadingView()
                switch result {
                case .success(let photos):
                    self.photos.append(contentsOf: photos)
                    self.tableViewManager.items = self.photos
                    if self.photos.isEmpty {
                        let message = "Sorry, no photos found. Try searching for something else 🙂"
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: message, in: self.view)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    self.presentDCDAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Ok")
                }
            }
        }
}
