import UIKit
import UniformTypeIdentifiers

class ShareViewController: UIViewController {
    
    // MARK: - UI Elements
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "traHerve"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        let fullText = "traHerve"
        let attributedString = NSMutableAttributedString(string: fullText)
        if let range = fullText.range(of: "H") {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.backgroundColor, value: UIColor.orange, range: nsRange)
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
        }
        
        label.attributedText = attributedString
        return label
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "One way Flights to Muscat for 25th Feb, 2025"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var flightCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var airlineLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "oman_air_logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var airlineNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Oman Air"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₹10,183"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "15:30"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var departureCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "HYD"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.text = "3h 35"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var directLabel: UILabel = {
        let label = UILabel()
        label.text = "Direct"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "17:35"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var arrivalCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "MCT"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.text = "Source:"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var skyscannerLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "skyscanner_logo")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SAVE TO MY TRIP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 0.93, green: 0.53, blue: 0.31, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSharedContent()
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
