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
        private let containerStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 20
            stack.alignment = .leading
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        private let headerLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            label.numberOfLines = 0
            label.textColor = .label
            return label
        }()
        
        private let providerStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 8
            stack.alignment = .leading
            return stack
        }()
        
        private let skyscannerLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.textColor = .secondaryLabel
            label.text = "Skyscanner"
            return label
        }()
        
        private let saveButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("SAVE TO MY TRIP", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 8
            button.setTitleColor(.white, for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
            return button
        }()
        
        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupConstraints()
            loadSharedContent()
            setupActions()
        }
        
        // MARK: - Setup
        private func setupUI() {
            view.backgroundColor = .systemBackground
            view.addSubview(containerStack)
            
            containerStack.addArrangedSubview(headerLabel)
            containerStack.addArrangedSubview(providerStack)
            
            providerStack.addArrangedSubview(skyscannerLabel)
            providerStack.addArrangedSubview(saveButton)
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate([
                containerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                containerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                containerStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
                    guard let url = item as? URL else { return }
                    
                    print("URL is - \(url)")
                    
                    DispatchQueue.main.async {
                        self?.headerLabel.text = "One way Flights to Muscat for 25th Feb, 2025"
                        // Add logic to parse URL and update UI accordingly
                    }
                }
            }
        }
        
        // MARK: - Actions
        private func setupActions() {
            saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        }
        
        @objc private func handleSave() {
            // Add your SwiftData saving logic here
            print("Saving trip to SwiftData...")
            
            // Dismiss the extension
            extensionContext?.completeRequest(returningItems: nil)
        }
}
