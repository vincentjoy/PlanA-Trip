import Foundation
import SwiftSoup

struct WebsiteMetadata {
    var title: String?
    var description: String?
    var ogTitle: String?
    var ogDescription: String?
    var ogImage: String?
    var favicon: String?
}

class WebsiteMetadataFetcher {
    
    // Main function to fetch metadata
    static func fetchMetadata(from url: URL, completion: @escaping (WebsiteMetadata?, Error?) -> Void) {
        
        print("Url is - ", url.absoluteString)
        
        // Create URL session data task
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Check for errors
            if let error = error {
                completion(nil, error)
                return
            }
            
            // Ensure we have data
            guard let data = data,
                  let htmlString = String(data: data, encoding: .utf8) else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            
            do {
                // Parse HTML
                let doc = try SwiftSoup.parse(htmlString)
                
                // Extract metadata
                var metadata = WebsiteMetadata()
                
                // Title
                metadata.title = try? doc.title()
                
                // Meta tags
                metadata.description = try? doc.select("meta[name='description']").first()?.attr("content")
                
                // Open Graph tags
                metadata.ogTitle = try? doc.select("meta[property='og:title']").first()?.attr("content")
                metadata.ogDescription = try? doc.select("meta[property='og:description']").first()?.attr("content")
                metadata.ogImage = try? doc.select("meta[property='og:image']").first()?.attr("content")
                
                // Favicon
                if let faviconLink = try? doc.select("link[rel='icon']").first() {
                    metadata.favicon = try? faviconLink.attr("href")
                }
                
                // Complete with metadata
                completion(metadata, nil)
                
            } catch {
                completion(nil, error)
            }
        }
        
        // Start the network request
        task.resume()
    }
}
