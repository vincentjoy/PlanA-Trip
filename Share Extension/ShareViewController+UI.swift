import UIKit

extension ShareViewController {
    
    // MARK: - UI Setup
    func setupUI() {
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

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 450)
        ])
    }
    
    private func setupHeaderView() {
        containerView.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            headerView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        headerView.addSubview(logoLabel)
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
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupFlightCardView() {
        containerView.addSubview(flightCardView)
        
        NSLayoutConstraint.activate([
            flightCardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            flightCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            flightCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            flightCardView.heightAnchor.constraint(equalToConstant: 130)
        ])
        
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
        containerView.addSubview(sourceLabel)
        containerView.addSubview(skyscannerLogoImageView)
        
        NSLayoutConstraint.activate([
            sourceLabel.topAnchor.constraint(equalTo: flightCardView.bottomAnchor, constant: 16),
            sourceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            skyscannerLogoImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            skyscannerLogoImageView.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 8),
            skyscannerLogoImageView.widthAnchor.constraint(equalToConstant: 120),
            skyscannerLogoImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupSaveButton() {
        containerView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            saveButton.topAnchor.constraint(equalTo: skyscannerLogoImageView.bottomAnchor, constant: 40),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
