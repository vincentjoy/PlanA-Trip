//
//  ShareViewController.swift
//  Share Extension
//
//  Created by Vincent Joy on 29/10/24.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Access the first item provided to the share extension
        if let item = self.extensionContext?.inputItems.first as? NSExtensionItem {
            for attachment in item.attachments ?? [] {
                if attachment.hasItemConformingToTypeIdentifier("public.text") {
                    attachment.loadItem(forTypeIdentifier: "public.text", options: nil) { (text, error) in
                        if let sharedText = text as? String {
                            // Handle shared text
                            print("Shared Text: \(sharedText)")
                        }
                    }
                } else if attachment.hasItemConformingToTypeIdentifier("public.image") {
                    attachment.loadItem(forTypeIdentifier: "public.image", options: nil) { (image, error) in
                        if let sharedImage = image as? UIImage {
                            // Handle shared image
                            print("Shared Image: \(sharedImage)")
                        }
                    }
                }
            }
        }
    }


    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
