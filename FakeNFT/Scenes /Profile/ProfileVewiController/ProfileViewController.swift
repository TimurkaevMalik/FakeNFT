//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Malik Timurkaev on 13.06.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var linkButton = UIButton()
    private lazy var redactButton = UIButton(type: .system)
    private lazy var userNameLabel = UILabel()
    private lazy var userDescriptionView = UITextView()
    private lazy var userPhotoView = UIImageView(image: UIImage(named: "avatarPlug"))
    
    private let servicesAssembly: ServicesAssembly
    
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
        userNameLabel.text = "Name wasn't found"
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
        userDescriptionView.font = UIFont.caption2
        
        let text = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing =  3
        let attributes = [NSAttributedString.Key.paragraphStyle : style,
                          .foregroundColor: UIColor.ypBlack]
        
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
        linkButton.setTitle("Link wasn't found", for: .normal)
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
}
