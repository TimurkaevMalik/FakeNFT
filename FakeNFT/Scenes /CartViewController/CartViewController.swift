//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Malik Timurkaev on 13.06.2024.
//

import UIKit

final class CartViewController: UIViewController {
    
    // MARK: - Public Properties
    
    let servicesAssembly: ServicesAssembly
    
    // MARK: - Private Properties
    
    private let bottomBackground = UIView()
    private let nftTableView = UITableView()
    private let paymentButton = UIButton()
    private let nftCountLable = UILabel()
    private let nftPriceLable = UILabel()
    
    // MARK: - Initializers
    
    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Public Methods
    // MARK: - Private Methods
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "YPWhite")
        addBottomBackground()
        addNftTableView()
        addPaymentButton()
        addNftCountLable()
        addNftPriceLable()
    }
    
    private func addBottomBackground() {
        bottomBackground.backgroundColor = UIColor(named: "YPLightGray")
        bottomBackground.layer.masksToBounds = true
        bottomBackground.layer.cornerRadius = 12
        bottomBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomBackground)
        NSLayoutConstraint.activate([
            bottomBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBackground.heightAnchor.constraint(equalToConstant: 159)
        ])
    }
    
    private func addNftTableView() {
        nftTableView.delegate = self
        nftTableView.dataSource = self
        nftTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nftTableView)
        NSLayoutConstraint.activate([
            nftTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            nftTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nftTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nftTableView.bottomAnchor.constraint(equalTo: bottomBackground.topAnchor)
        ])
    }

    private func addPaymentButton() {
        paymentButton.setTitle("К оплате", for: .normal)
        paymentButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        paymentButton.setTitleColor(UIColor(named: "YPWhite"), for: .normal)
        paymentButton.backgroundColor = UIColor(named: "YPBlack")
        paymentButton.layer.masksToBounds = true
        paymentButton.layer.cornerRadius = 16
        paymentButton.addTarget(self, action: #selector(paymentButtonTap), for: .touchUpInside)
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        bottomBackground.addSubview(paymentButton)
        NSLayoutConstraint.activate([
            paymentButton.topAnchor.constraint(equalTo: bottomBackground.topAnchor, constant: 16),
            paymentButton.trailingAnchor.constraint(equalTo: bottomBackground.trailingAnchor, constant: -16),
            paymentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            paymentButton.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    private func addNftCountLable() {
        nftCountLable.text = "3 NFT"
        nftCountLable.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        nftCountLable.textColor = UIColor(named: "YPBlack")
        nftCountLable.translatesAutoresizingMaskIntoConstraints = false
        bottomBackground.addSubview(nftCountLable)
        NSLayoutConstraint.activate([
            nftCountLable.leadingAnchor.constraint(equalTo: bottomBackground.leadingAnchor, constant: 16),
            nftCountLable.topAnchor.constraint(equalTo: bottomBackground.topAnchor, constant: 16)
        ])
    }
    
    private func addNftPriceLable() {
        nftPriceLable.text = "5,34 ETH"
        nftPriceLable.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        nftPriceLable.textColor = UIColor(named: "YPGreen")
        nftPriceLable.translatesAutoresizingMaskIntoConstraints = false
        bottomBackground.addSubview(nftPriceLable)
        NSLayoutConstraint.activate([
            nftPriceLable.leadingAnchor.constraint(equalTo: bottomBackground.leadingAnchor, constant: 16),
            nftPriceLable.topAnchor.constraint(equalTo: nftCountLable.bottomAnchor, constant: 2)
        ])
    }
    // MARK: - Public Actions
    // MARK: - Private Actions
    
    @objc private func paymentButtonTap() {
        print("Кнопка оплаты нажата")
    }
    
}
