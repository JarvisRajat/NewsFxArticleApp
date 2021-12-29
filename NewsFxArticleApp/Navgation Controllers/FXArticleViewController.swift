//
//  FXArticleViewController.swift
//  NewsFxArticleApp
//
//  Created by Rajat Raj on 24/12/21.
//

import UIKit

class FXArticleViewController: UIViewController {

    @IBOutlet private weak var articleSearchBar: UISearchBar!
    @IBOutlet internal weak var articleListTable: UITableView!
    var articleData = [Data]()
    var navigationTitle: String?
    private var originalDataOfArticles = [Data]()
    private var originalDataOfDailyBriefings = [[Data]]()
    var dailyBriefingData: DailyBriefingData?
    private var dailyBriefValues: [DailyBriefings] = [.eu, .asia, .us]
    internal var dailyBriefing = [[Data]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        self.title = navigationTitle
        dailyBriefing = [(dailyBriefingData?.eu ?? []),
                         (dailyBriefingData?.asia ?? []),
                         (dailyBriefingData?.us ?? [])]
        if dailyBriefingData == nil {
            originalDataOfArticles = articleData
        } else {
            originalDataOfDailyBriefings = dailyBriefing
        }
        articleSearchBar.placeholder = "Search Your Article by title."
        registerCell()
    }
    private func registerCell() {
        articleListTable.register(UINib(nibName: "ArticleDetailsCell", bundle: Bundle.main), forCellReuseIdentifier: "ArticleDetailsCell")
        articleListTable.register(UINib(nibName: "DailyBriefingHeaderView", bundle: Bundle.main),
                                  forHeaderFooterViewReuseIdentifier: "DailyBriefingHeaderView")
    }
}
extension FXArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (dailyBriefingData == nil ? 1 : dailyBriefing.count)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dailyBriefingData == nil ? articleData.count : dailyBriefing[section].count)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (dailyBriefingData == nil ? CGFloat.leastNormalMagnitude : UITableView.automaticDimension)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DailyBriefingHeaderView") as? DailyBriefingHeaderView
                else { return UIView() }
        headerView.layer.cornerRadius = 18
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = UIColor.systemGray.cgColor
        headerView.datasource = dailyBriefValues[section].rawValue
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleDetailsCell", for: indexPath) as? ArticleDetailsCell
        else { return UITableViewCell() }
        cell.datasource = (dailyBriefingData == nil) ? articleData[indexPath.row] : dailyBriefing[indexPath.section][indexPath.row]
        cell.isBorderDisplay = (dailyBriefingData == nil) ? true : false
        cell.buttonTapHandler = { [weak self] () in
            guard let strongSelf = self else {return}
            let targetController = DetailsOnWebController(nibName: "DetailsOnWebController", bundle: nil)
            targetController.path = strongSelf.dailyBriefingData == nil ? strongSelf.articleData[indexPath.row].url : strongSelf.dailyBriefing[indexPath.section][indexPath.row].url
            strongSelf.navigationController?.pushViewController(targetController, animated: true)
        }
        cell.authorTapHandler = { [weak self] () in
            guard let strongSelf = self else {return}
            let targetController = AuthorProfileViewController(nibName: "AuthorProfileViewController", bundle: nil)
            targetController.authorData = strongSelf.dailyBriefingData == nil ? strongSelf.articleData[indexPath.row].authors?.first : strongSelf.dailyBriefing[indexPath.section][indexPath.row].authors?.first
            strongSelf.navigationController?.pushViewController(targetController, animated: true)
        }
        return cell
    }
}

extension FXArticleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if dailyBriefingData == nil {
            articleData = searchText.isEmpty ? originalDataOfArticles : originalDataOfArticles.filter({data -> Bool in
                return data.title?.range(of: searchText, options: .caseInsensitive) != nil
            })
        } else {
            if searchText.isEmpty {
                dailyBriefing = originalDataOfDailyBriefings
            } else {
                var filteredDataSource : [[Data]] = []
                for data in originalDataOfDailyBriefings {
                    let filteredItems = data.filter { (item) -> Bool in
                        if item.title?.range(of: searchText, options: .caseInsensitive) != nil {
                            return true
                        }
                        return false
                    }
                    filteredDataSource.append(filteredItems)
                }
                dailyBriefing = filteredDataSource
            }
        }
        articleListTable.reloadData()
    }
}
