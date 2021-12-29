//
//  TypeHeaderCell.swift
//  NewsFxArticleApp
//
//  Created by Rajat Raj on 24/12/21.
//

import UIKit

struct CellData {
    let cellHeaders: TypeHeader?
    let data: FxArticleRuleEngine?
}

class TypeHeaderCell: BaseTableViewCell<CellData> {

    @IBOutlet private weak var headerTitle: UILabel!
    @IBOutlet private weak var cellContentView: UIView!
    override var datasource: CellData! {
        didSet {
            configureCellStyle()
            switch datasource.cellHeaders {
            case .breakingNews:
                headerTitle.text = TypeHeader.breakingNews.rawValue
                cellContentView.layer.borderColor = datasource.data?.breakingNews == nil ? UIColor.systemRed.cgColor : UIColor.systemBlue.cgColor
            case .topNews:
                headerTitle.text = TypeHeader.topNews.rawValue
                cellContentView.layer.borderColor = datasource.data?.topNews == nil ? UIColor.systemRed.cgColor : UIColor.systemBlue.cgColor
            case .dailyBriefings:
                headerTitle.text = TypeHeader.dailyBriefings.rawValue
                cellContentView.layer.borderColor = datasource.data?.dailyBriefings == nil ? UIColor.systemRed.cgColor : UIColor.systemBlue.cgColor
            case .technicalAnalysis:
                headerTitle.text = TypeHeader.technicalAnalysis.rawValue
                cellContentView.layer.borderColor = datasource.data?.technicalAnalysis == nil ? UIColor.systemRed.cgColor : UIColor.systemBlue.cgColor
            case .specialReport:
                headerTitle.text = TypeHeader.specialReport.rawValue
                cellContentView.layer.borderColor = datasource.data?.specialReport == nil ? UIColor.systemRed.cgColor : UIColor.systemBlue.cgColor
            case .none:
                return
            }
        }
    }
    
    private func configureCellStyle() {
        cellContentView.layer.cornerRadius = 18
        cellContentView.layer.borderWidth = 2
    }
}
