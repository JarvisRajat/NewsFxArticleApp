//
//  DailyBriefingHeaderView.swift
//  NewsFxArticleApp
//
//  Created by Rajat Raj on 27/12/21.
//

import UIKit

class DailyBriefingHeaderView: BaseHeaderFooterView<String>{
    
    @IBOutlet private weak var headerTitle: UILabel!
    override var datasource: String! {
        didSet {
            headerTitle.text = datasource
        }
    }
}
