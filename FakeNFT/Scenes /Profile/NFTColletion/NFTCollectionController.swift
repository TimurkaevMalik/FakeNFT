//
//  NFTCollectionController.swift
//  FakeNFT
//
//  Created by Malik Timurkaev on 25.06.2024.
//

import UIKit


final class NFTCollectionController: UIViewController {
    
    private lazy var titleLabel = UILabel()
    private lazy var topViewsContainer = UIView()
    private lazy var centralPlugLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCentralPlugLabel()
        configureTopViewsContainer()
        configureTitleLabel()
    }
    
    private func configureTopViewsContainer() {
        topViewsContainer.backgroundColor = .ypWhite
        topViewsContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topViewsContainer)
        
        NSLayoutConstraint.activate([
            topViewsContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topViewsContainer.heightAnchor.constraint(equalToConstant: 42),
            topViewsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topViewsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    private func configureTitleLabel(){
        titleLabel.textColor = .ypBlack
        titleLabel.text = "Мои NFT"
        titleLabel.font = UIFont.bodyBold
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: topViewsContainer.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: topViewsContainer.centerXAnchor)
        ])
    }
    
    private func configureCentralPlugLabel(){
        centralPlugLabel.textColor = .ypBlack
        
        centralPlugLabel.text = "У вас ещё нет NFT"
        centralPlugLabel.textAlignment = .center
        centralPlugLabel.font = .bodyBold
        centralPlugLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centralPlugLabel)
        
        NSLayoutConstraint.activate([
            centralPlugLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            centralPlugLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            centralPlugLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centralPlugLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
        ])
    }
}
