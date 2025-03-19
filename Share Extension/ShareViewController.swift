//
//  ShareViewController.swift
//  Share Extension
//
//  Created by Vincent Joy on 29/10/24.
//

import UIKit
import Social
import MobileCoreServices
import UniformTypeIdentifiers

class ShareViewController: SLComposeServiceViewController {
    
    override func isContentValid() -> Bool {
        // Validate content here
        return true
    }

    override func didSelectPost() {
        guard let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let itemProvider = extensionItem.attachments?.first else {
            self.extensionContext?.completeRequest(returningItems: nil)
            return
        }
        
        if itemProvider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
            handleURL(itemProvider: itemProvider)
        } else if itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
            handleImage(itemProvider: itemProvider)
        } else if itemProvider.hasItemConformingToTypeIdentifier(UTType.plainText.identifier) {
            handleText(itemProvider: itemProvider)
        }
    }
    
    private func handleURL(itemProvider: NSItemProvider) {
        itemProvider.loadItem(forTypeIdentifier: UTType.url.identifier) { (item, error) in
            guard let url = item as? URL else { return }
            // Handle the URL (save to app group container or process)
            self.extensionContext?.completeRequest(returningItems: nil)
        }
    }
    
    private func handleImage(itemProvider: NSItemProvider) {
        itemProvider.loadItem(forTypeIdentifier: UTType.image.identifier) { (item, error) in
            guard let imageURL = item as? URL else { return }
            // Handle image (save to shared container or process)
            self.extensionContext?.completeRequest(returningItems: nil)
        }
    }
    
    private func handleText(itemProvider: NSItemProvider) {
        itemProvider.loadItem(forTypeIdentifier: UTType.plainText.identifier) { (item, error) in
            guard let text = item as? String else { return }
            // Handle text
            self.extensionContext?.completeRequest(returningItems: nil)
        }
    }
}
