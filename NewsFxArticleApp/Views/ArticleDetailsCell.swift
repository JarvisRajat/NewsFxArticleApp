//
//  ArticleDetailsCell.swift
//  NewsFxArticleApp
//
//  Created by Rajat Raj on 27/12/21.
//

import UIKit

class ArticleDetailsCell: BaseTableViewCell<Data>  {
    
    @IBOutlet private weak var articlePoster: UIImageView!
    @IBOutlet private weak var articleTitle: UILabel!
    @IBOutlet private weak var articleDescription: UILabel!
    @IBOutlet private weak var newsKeyword: UILabel!
    @IBOutlet private weak var articleAuthor: UILabel!
    @IBOutlet private weak var articleInstrument: UILabel!
    @IBOutlet private weak var articleCategories: UILabel!
    @IBOutlet private weak var time: UILabel!
    @IBOutlet private weak var articleTag: UILabel!
    @IBOutlet private weak var lastUpdatedTime: UILabel!
    @IBOutlet private weak var showMore: UIButton!
    var buttonTapHandler: (() -> Void)?
    var authorTapHandler: (() -> Void)?
    var isBorderDisplay = true
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isBorderDisplay {
            let width = subviews[0].frame.width
            for view in subviews where view != contentView {
                if view.frame.width == width {
                    view.removeFromSuperview()
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        articleAuthor.isUserInteractionEnabled = true
        articleAuthor.addGestureRecognizer(tapGesture)
    }
    override var datasource: Data! {
        didSet {
            if let imageUrl = datasource.headlineImageUrl, !imageUrl.isEmpty {
                Constants.shared.loadImage(imageView: articlePoster, imageUrl: imageUrl)
            }
            articleTitle.text = datasource.title
            articleDescription.text = datasource.description
            let newsKeywords = datasource.newsKeywords ?? ""
            let instruments = datasource.instruments ?? []
            let tags = datasource.tags ?? []
            let categories = datasource.categories ?? []
            newsKeyword.attributedText = !newsKeywords.isEmpty ? Constants.shared.textStyling(mainString: "News Keywords - \(newsKeywords)", styledString: "News Keywords -") : NSMutableAttributedString()
            articleInstrument.attributedText = !instruments.isEmpty ? Constants.shared.textStyling(mainString: "Instruments - \(instruments.joined(separator: ", "))", styledString: "Instruments -") : NSMutableAttributedString()
            articleTag.attributedText = !tags.isEmpty ? Constants.shared.textStyling(mainString: "Tags - \(tags.joined(separator: ", "))", styledString: "Tags -") : NSMutableAttributedString()
            articleCategories.attributedText = !categories.isEmpty ? Constants.shared.textStyling(mainString: "Categories - \(categories.joined(separator: ", "))", styledString: "Categories -") : NSMutableAttributedString()
            articleAuthor.attributedText = Constants.shared.textStyling(mainString: "Author - \(datasource.authors?.first?.name ?? "")", styledString: "Author -")
            time.text = "Date & Time - \(Constants.shared.time(ms: datasource.displayTimestamp ?? 0))"
            lastUpdatedTime.text = "Last Updated at \(Constants.shared.time(ms: datasource.lastUpdatedTimestamp ?? 0))"
        }
    }
    @objc private func handleTap() {
        print("Author Text tapped", articleAuthor.text as Any)
        authorTapHandler?()
    }
    
    @IBAction private func showMoreButtonAction(_ sender: Any) {
        buttonTapHandler?()
    }
}
