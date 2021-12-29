//
//  ServiceManager.swift
//  NewsFxArticleApp
//
//  Created by Rajat Raj on 27/12/21.
//

import Foundation
extension ViewController {
     func getData(from url: String = "https://content.dailyfx.com/api/v1/dashboard") {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            var result: FxArticleRuleEngine?
            do {
                result = try JSONDecoder().decode(FxArticleRuleEngine.self, from: data)
            }
            catch {
                print("Failed on conversion \(error.localizedDescription)")
            }
            guard let jsonData = result else {
                return
            }
            DispatchQueue.main.async {
                self.fetchData(data: jsonData)
            }
        })
        task.resume()
    }
    private func fetchData(data: FxArticleRuleEngine?) {
        responseData = data
        tableView.reloadData()
        tableView.isHidden = false
    }
}
