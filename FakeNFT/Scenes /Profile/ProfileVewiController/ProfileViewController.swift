//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Malik Timurkaev on 13.06.2024.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    private lazy var linkButton = UIButton()
    private lazy var redactButton = UIButton(type: .system)
    private lazy var userNameLabel = UILabel()
    private lazy var userDescriptionView = UITextView()
    private lazy var userPhotoView = UIImageView(image: UIImage(named: "avatarPlug"))
    
    private let fetchProfileService = FetchProfileService.shared
    private let servicesAssembly: ServicesAssembly
    private let tableCellIdentifier = "tableCellIdentifier"
    private let tableViewCells = ["Мои NFT", "Избранные NFT", "О разрабротчике"]
    
    private var nfts: [String] = []
    private var likes: [String] = []
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhite
        configureUserPhoto()
        configureUserName()
        configureRedactButton()
        configureUserDescription()
        configureLinkButton()
        configureTableView()
        fetchProfile()
    }
    
    @objc func redactButtonTapped() {
        let viewController = RedactingViewController()
        present(viewController, animated: true)
    }
    
    @objc func linkButtonTapped() {
        print("Link button tapped")
    }
    
    private func configureUserPhoto() {
        userPhotoView.layer.masksToBounds = true
        userPhotoView.layer.cornerRadius = 35
        userPhotoView.clipsToBounds = true
        userPhotoView.contentMode = .scaleAspectFill
        
        userPhotoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userPhotoView)
        
        NSLayoutConstraint.activate([
            userPhotoView.widthAnchor.constraint(equalToConstant: 70),
            userPhotoView.heightAnchor.constraint(equalToConstant: 70),
            userPhotoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            userPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func configureUserName() {
        userNameLabel.textColor = .ypBlack
        userNameLabel.text = "Поиск имени и фамилии"
        userNameLabel.font = UIFont.headline3
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            userNameLabel.centerYAnchor.constraint(equalTo: userPhotoView.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoView.trailingAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func configureRedactButton() {
        redactButton.tintColor = .ypBlack
        redactButton.setImage(UIImage(named: "editButtonImage"), for: .normal)
        redactButton.addTarget(self, action: #selector(redactButtonTapped), for: .touchUpInside)
        
        redactButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redactButton)
        
        NSLayoutConstraint.activate([
            redactButton.widthAnchor.constraint(equalToConstant: 42),
            redactButton.heightAnchor.constraint(equalToConstant: 42),
            redactButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 46),
            redactButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -9)
        ])
    }
    
    private func configureUserDescription() {
        userDescriptionView.backgroundColor = .clear
        userDescriptionView.isEditable = false
        userDescriptionView.isScrollEnabled = false
        userDescriptionView.sizeToFit()
        
        userDescriptionView.textContainer.lineFragmentPadding = 0
        userDescriptionView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        userDescriptionView.textAlignment = .left
        userDescriptionView.textContainer.maximumNumberOfLines = 4
        
        let text = "Поиск описания"
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing =  3
        let attributes = [NSAttributedString.Key.paragraphStyle : style,
                          .foregroundColor: UIColor.ypBlack,
                          .font: UIFont.caption2
        ]
        
        userDescriptionView.attributedText = NSAttributedString(string: text, attributes: attributes as [NSAttributedString.Key : Any])
        
        userDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userDescriptionView)
        
        NSLayoutConstraint.activate([
            userDescriptionView.topAnchor.constraint(equalTo: userPhotoView.bottomAnchor, constant: 20),
            userDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func configureLinkButton() {
        linkButton.setTitleColor(.ypBlue, for: .normal)
        linkButton.setTitle("Поиск ссылки сайта", for: .normal)
        linkButton.titleLabel?.font = UIFont.caption1
        linkButton.contentHorizontalAlignment = .left
        
        linkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
        
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(linkButton)
        
        NSLayoutConstraint.activate([
            linkButton.heightAnchor.constraint(equalToConstant: 20),
            linkButton.topAnchor.constraint(equalTo: userDescriptionView.bottomAnchor, constant: 8),
            linkButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            linkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileTableCell.self, forCellReuseIdentifier: tableCellIdentifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 1000)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 44),
            tableView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 162),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func fetchProfile() {
        
        let token = "838f0366-1991-4b2c-bd1c-d136072f8080"
        
        UIBlockingProgressHUD.show()
        
        fetchProfileService.fecthProfile(token) { result in
            
            switch result {
                
            case .success(let profile):
                self.updateProfileInfo(profile)
            case .failure(let error):
                print(error)
            }
            
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    func updateProfileInfo(_ profile: ProfileResult) {
        userNameLabel.text = profile.name
        userDescriptionView.text = profile.description
        linkButton.setTitle(profile.website, for: .normal) 
        
        updateUserPhotoWith(url: profile.avatar)
        updateNftsArray(profile.nfts)
        updateLikesArray(profile.likes)
        
        tableView.reloadData()
    }
    
    private func updateUserPhotoWith(url: String) {
        guard let avatarUrl = URL(string: url) else {
            return
        }
        userPhotoView.kf.setImage(with: avatarUrl)
    }
    
    private func updateNftsArray(_ nfts: [String?]) {
        
        for nft in nfts {
            if let nft {
                self.nfts.append(nft)
            }
        }
    }
    
    private func updateLikesArray(_ likes: [String?]) {
        for like in likes {
            if let like {
                self.likes.append(like)
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as? ProfileTableCell else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            cell.cellTextLabel.text = tableViewCells[indexPath.row] + " " + "(\(nfts.count))"
        } else if indexPath.row == 1 {
            cell.cellTextLabel.text = tableViewCells[indexPath.row] + " " + "(\(likes.count))"
        } else {
            cell.cellTextLabel.text = tableViewCells[indexPath.row]
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
