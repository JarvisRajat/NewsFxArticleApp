//
//  DataHelper.swift
//  NewsFxArticleApp
//
//  Created by Rajat Raj on 24/12/21.
//

import Foundation
import UIKit

enum TypeHeader: String {
    case breakingNews       = "Breaking News"
    case topNews            = "Top News"
    case dailyBriefings     = "Daily Briefings"
    case technicalAnalysis  = "Technical Analysis"
    case specialReport      = "Special Report"
}

enum DailyBriefings: String {
    case eu = "Europe"
    case asia = "Asia"
    case us = "United States"
}

extension UIViewController {
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: 16, y: self.view.frame.size.height - 80, width: self.view.frame.size.width - 32, height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 12.0)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
extension UIImageView {
    func loadImage(from urlString: String?, complition: @escaping (UIImage?) -> Void) {
        let encodedUrlString = urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = encodedUrlString,
              let imageURL = URL(string: urlString) else {
                  DispatchQueue.main.async {
                      complition(nil)
                  }
                  return
              }
        
        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL)
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    complition(image)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, _) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            complition(image)
                        }
                    } else {
                        DispatchQueue.main.async {
                            complition(nil)
                        }
                    }
                }).resume()
            }
        }
    }
    func makeRounded(_ removeBorder: Bool? = nil, _ backgroundColor: UIColor? = nil, _ isRounded: Bool? = nil) {
           removeBorder == nil ? self.layer.borderWidth = 1 : nil
           if let backgroundColor = backgroundColor {
               self.image = self.image?.withRenderingMode(.alwaysTemplate)
               self.tintColor = backgroundColor
           }
           self.contentMode = isRounded ?? false ? UIView.ContentMode.scaleAspectFill : UIView.ContentMode.scaleAspectFit
           self.layer.masksToBounds = false
           self.layer.borderColor = UIColor.black.cgColor
           self.layer.cornerRadius = self.frame.height / 2
           self.clipsToBounds = true
       }
}
