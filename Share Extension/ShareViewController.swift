//
//  ShareViewController.swift
//  Share Extension
//
//  Created by Vincent Joy on 29/10/24.
//

import UIKit
import UniformTypeIdentifiers

class ShareViewController: UIViewController {
    
    // MARK: - UI Elements
    private let containerView = UIView()
    private let headerView = UIView()
    private let logoLabel = UILabel()
    private let dismissButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let flightCardView = UIView()
    private let airlineLogoImageView = UIImageView()
    private let airlineNameLabel = UILabel()
    private let priceLabel = UILabel()
    private let departureTimeLabel = UILabel()
    private let departureCodeLabel = UILabel()
    private let durationLabel = UILabel()
    private let directLabel = UILabel()
    private let arrivalTimeLabel = UILabel()
    private let arrivalCodeLabel = UILabel()
    private let sourceLabel = UILabel()
    private let skyscannerLogoImageView = UIImageView()
    private let saveButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSharedContent()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        setupContainerView()
        setupHeaderView()
        setupTitleLabel()
        setupFlightCardView()
        setupSourceView()
        setupSaveButton()
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 450)
        ])
    }
    
    private func setupHeaderView() {
        containerView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            headerView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Logo Label (traHerve)
        logoLabel.text = "traHerve"
        logoLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Custom styling for the "H" in traHerve
        let fullText = "traHerve"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        if let range = fullText.range(of: "H") {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.backgroundColor, value: UIColor.orange, range: nsRange)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }
        
        logoLabel.attributedText = attributedString
        
        headerView.addSubview(logoLabel)
        
        // Dismiss button (X)
        dismissButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        dismissButton.tintColor = .gray
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        
        headerView.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            logoLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            logoLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            dismissButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            dismissButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 24),
            dismissButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "One way Flights to Muscat for 25th Feb, 2025"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupFlightCardView() {
        flightCardView.backgroundColor = .white
        flightCardView.layer.borderColor = UIColor.lightGray.cgColor
        flightCardView.layer.borderWidth = 1
        flightCardView.layer.cornerRadius = 8
        flightCardView.clipsToBounds = true
        flightCardView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(flightCardView)
        
        NSLayoutConstraint.activate([
            flightCardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            flightCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            flightCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            flightCardView.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        // Airline Logo and Name
        airlineLogoImageView.image = UIImage(named: "oman_air_logo") // You'll need to add this asset
        airlineLogoImageView.contentMode = .scaleAspectFit
        airlineLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        airlineNameLabel.text = "Oman Air"
        airlineNameLabel.font = UIFont.systemFont(ofSize: 14)
        airlineNameLabel.textColor = .darkGray
        airlineNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Price Label
        priceLabel.text = "₹10,183"
        priceLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        priceLabel.textAlignment = .right
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Flight Details
        departureTimeLabel.text = "15:30"
        departureTimeLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        departureTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        departureCodeLabel.text = "HYD"
        departureCodeLabel.font = UIFont.systemFont(ofSize: 16)
        departureCodeLabel.textColor = .darkGray
        departureCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        durationLabel.text = "3h 35"
        durationLabel.font = UIFont.systemFont(ofSize: 14)
        durationLabel.textColor = .darkGray
        durationLabel.textAlignment = .center
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        directLabel.text = "Direct"
        directLabel.font = UIFont.systemFont(ofSize: 14)
        directLabel.textColor = UIColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1.0) // Teal color
        directLabel.textAlignment = .center
        directLabel.translatesAutoresizingMaskIntoConstraints = false
        
        arrivalTimeLabel.text = "17:35"
        arrivalTimeLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        arrivalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        arrivalCodeLabel.text = "MCT"
        arrivalCodeLabel.font = UIFont.systemFont(ofSize: 16)
        arrivalCodeLabel.textColor = .darkGray
        arrivalCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add all elements to flight card
        flightCardView.addSubview(airlineLogoImageView)
        flightCardView.addSubview(airlineNameLabel)
        flightCardView.addSubview(priceLabel)
        flightCardView.addSubview(departureTimeLabel)
        flightCardView.addSubview(departureCodeLabel)
        flightCardView.addSubview(durationLabel)
        flightCardView.addSubview(directLabel)
        flightCardView.addSubview(arrivalTimeLabel)
        flightCardView.addSubview(arrivalCodeLabel)
        
        // Add flight arrow
        let flightArrowImageView = UIImageView()
        flightArrowImageView.image = UIImage(systemName: "arrow.right")
        flightArrowImageView.tintColor = .lightGray
        flightArrowImageView.contentMode = .scaleAspectFit
        flightArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        flightCardView.addSubview(flightArrowImageView)
        
        // Flight path line
        let flightPathView = UIView()
        flightPathView.backgroundColor = .lightGray
        flightPathView.translatesAutoresizingMaskIntoConstraints = false
        flightCardView.addSubview(flightPathView)
        
        NSLayoutConstraint.activate([
            airlineLogoImageView.topAnchor.constraint(equalTo: flightCardView.topAnchor, constant: 16),
            airlineLogoImageView.leadingAnchor.constraint(equalTo: flightCardView.leadingAnchor, constant: 16),
            airlineLogoImageView.widthAnchor.constraint(equalToConstant: 24),
            airlineLogoImageView.heightAnchor.constraint(equalToConstant: 24),
            
            airlineNameLabel.centerYAnchor.constraint(equalTo: airlineLogoImageView.centerYAnchor),
            airlineNameLabel.leadingAnchor.constraint(equalTo: airlineLogoImageView.trailingAnchor, constant: 8),
            
            priceLabel.topAnchor.constraint(equalTo: flightCardView.topAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: flightCardView.trailingAnchor, constant: -16),
            
            departureTimeLabel.topAnchor.constraint(equalTo: airlineLogoImageView.bottomAnchor, constant: 20),
            departureTimeLabel.leadingAnchor.constraint(equalTo: flightCardView.leadingAnchor, constant: 16),
            
            departureCodeLabel.topAnchor.constraint(equalTo: departureTimeLabel.bottomAnchor, constant: 4),
            departureCodeLabel.leadingAnchor.constraint(equalTo: departureTimeLabel.leadingAnchor),
            
            flightPathView.centerYAnchor.constraint(equalTo: departureTimeLabel.centerYAnchor),
            flightPathView.leadingAnchor.constraint(equalTo: departureTimeLabel.trailingAnchor, constant: 16),
            flightPathView.trailingAnchor.constraint(equalTo: arrivalTimeLabel.leadingAnchor, constant: -16),
            flightPathView.heightAnchor.constraint(equalToConstant: 1),
            
            durationLabel.centerXAnchor.constraint(equalTo: flightPathView.centerXAnchor),
            durationLabel.bottomAnchor.constraint(equalTo: flightPathView.topAnchor, constant: -4),
            
            directLabel.centerXAnchor.constraint(equalTo: flightPathView.centerXAnchor),
            directLabel.topAnchor.constraint(equalTo: flightPathView.bottomAnchor, constant: 4),
            
            flightArrowImageView.centerXAnchor.constraint(equalTo: flightPathView.centerXAnchor),
            flightArrowImageView.centerYAnchor.constraint(equalTo: flightPathView.centerYAnchor),
            flightArrowImageView.widthAnchor.constraint(equalToConstant: 16),
            flightArrowImageView.heightAnchor.constraint(equalToConstant: 16),
            
            arrivalTimeLabel.topAnchor.constraint(equalTo: airlineLogoImageView.bottomAnchor, constant: 20),
            arrivalTimeLabel.trailingAnchor.constraint(equalTo: flightCardView.trailingAnchor, constant: -16),
            
            arrivalCodeLabel.topAnchor.constraint(equalTo: arrivalTimeLabel.bottomAnchor, constant: 4),
            arrivalCodeLabel.trailingAnchor.constraint(equalTo: arrivalTimeLabel.trailingAnchor)
        ])
    }
    
    private func setupSourceView() {
        sourceLabel.text = "Source:"
        sourceLabel.font = UIFont.systemFont(ofSize: 14)
        sourceLabel.textColor = .darkGray
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        skyscannerLogoImageView.image = UIImage(named: "skyscanner_logo") // You'll need to add this asset
        skyscannerLogoImageView.contentMode = .scaleAspectFit
        skyscannerLogoImageView.tintColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0) // Blue color
        skyscannerLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(sourceLabel)
        containerView.addSubview(skyscannerLogoImageView)
        
        NSLayoutConstraint.activate([
            sourceLabel.topAnchor.constraint(equalTo: flightCardView.bottomAnchor, constant: 16),
            sourceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            skyscannerLogoImageView.leadingAnchor.constraint(equalTo: sourceLabel.trailingAnchor, constant: 8),
            skyscannerLogoImageView.centerYAnchor.constraint(equalTo: sourceLabel.centerYAnchor),
            skyscannerLogoImageView.widthAnchor.constraint(equalToConstant: 120),
            skyscannerLogoImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupSaveButton() {
        saveButton.setTitle("SAVE TO MY TRIP", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        saveButton.backgroundColor = UIColor(red: 0.93, green: 0.53, blue: 0.31, alpha: 1.0) // Orange-copper color
        saveButton.layer.cornerRadius = 8
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        containerView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            saveButton.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 40),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Content Handling
    private func loadSharedContent() {
        guard let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let itemProvider = extensionItem.attachments?.first else {
            extensionContext?.completeRequest(returningItems: nil)
            return
        }
        
        if itemProvider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
            itemProvider.loadItem(forTypeIdentifier: UTType.url.identifier) { [weak self] item, _ in
                guard let self, let url = item as? URL else { return }
                
                print("URL is - \(url)")
                
                DispatchQueue.main.async {
                    // Add logic to parse URL and update UI accordingly
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func handleSave() {
        // Add your SwiftData saving logic here
        print("Saving trip to SwiftData...")
        
        // Dismiss the extension
        extensionContext?.completeRequest(returningItems: nil)
    }
    
    // MARK: - Actions
    @objc private func dismissTapped() {
        
        // Dismiss the extension
        extensionContext?.completeRequest(returningItems: nil)
        
        dismiss(animated: true)
    }
    
    @objc private func saveTapped() {
        
        // Dismiss the extension
        extensionContext?.completeRequest(returningItems: nil)
    }
}
