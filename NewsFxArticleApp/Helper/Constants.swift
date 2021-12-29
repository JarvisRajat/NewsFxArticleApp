//
//  Constants.swift
//  NewsFxArticleApp
//
//  Created by Rajat Raj on 27/12/21.
//

import Foundation
import UIKit
class Constants {
    static let shared = Constants()
    func loadImage(imageView: UIImageView, imageUrl: String) {
        imageView.loadImage(from: imageUrl) { (image) in
            DispatchQueue.main.async {
                if let downloadedImage = image {
                    imageView.image = downloadedImage
                } else {
                    imageView.image = UIImage(named: "default_profile")
                }
            }
        }
    }
    func time(ms: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval((ms / 1000)))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    func textStyling(mainString: String, styledString: String) -> NSMutableAttributedString {
        let range = (mainString as NSString).range(of: styledString)
        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        return mutableAttributedString
    }
}
