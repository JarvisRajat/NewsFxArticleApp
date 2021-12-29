//
//  ViewController.swift
//  NewsFxArticleApp
//
//  Created by Rajat Raj on 24/12/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var typeHeaders: [TypeHeader] = [.breakingNews, .topNews, .dailyBriefings, .technicalAnalysis, .specialReport]
    var responseData: FxArticleRuleEngine?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        self.title = "FX News"
        getData()
        registerCell()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    private func registerCell() {
        tableView.register(UINib(nibName: "TypeHeaderCell", bundle: Bundle.main), forCellReuseIdentifier: "TypeHeaderCell")
       }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let height = screenHeight / CGFloat(typeHeaders.count)
        return height
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeHeaders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TypeHeaderCell", for: indexPath) as? TypeHeaderCell
                            else { return UITableViewCell() }
        cell.datasource = CellData(cellHeaders: typeHeaders[indexPath.row], data: responseData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navController = FXArticleViewController(nibName: "FXArticleViewController", bundle: nil)
        navController.navigationTitle = typeHeaders[indexPath.row].rawValue
        switch typeHeaders[indexPath.row] {
        case .breakingNews:
            if responseData?.breakingNews == nil {
                self.showToast(message: "No Breaking News Avalable")
            } else {
                navigationController?.pushViewController(navController, animated: true)
            }
        case .topNews:
            if responseData?.topNews == nil {
                self.showToast(message: "No Top News Avalable")
            } else {
                navController.articleData = responseData?.topNews ?? []
                navigationController?.pushViewController(navController, animated: true)
            }
        case .dailyBriefings:
            if responseData?.dailyBriefings == nil {
                self.showToast(message: "Nor Daily Briefing Avalable")
            } else {
                navController.dailyBriefingData = responseData?.dailyBriefings
                navigationController?.pushViewController(navController, animated: true)
            }
        case .technicalAnalysis:
            if responseData?.technicalAnalysis == nil {
                self.showToast(message: "No Technical Analysis Avalable")
            } else {
                navController.articleData = responseData?.technicalAnalysis ?? []
                navigationController?.pushViewController(navController, animated: true)
            }
        case .specialReport:
            if responseData?.specialReport == nil {
                self.showToast(message: "No Special Report Avalable")
            } else {
                navController.articleData = responseData?.specialReport ?? []
                navigationController?.pushViewController(navController, animated: true)
            }
        }
        
    }
}
