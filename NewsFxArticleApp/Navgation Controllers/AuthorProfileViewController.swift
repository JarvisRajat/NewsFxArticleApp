//
//  AuthorProfileViewController.swift
//  NewsFxArticleApp
//
//  Created by Rajat Raj on 28/12/21.
//

import UIKit

class AuthorProfileViewController: UIViewController {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var profilePicture: UIImageView!
    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var authorTitle: UILabel!
    @IBOutlet private weak var authorEmail: UILabel!
    @IBOutlet private weak var authorPhone: UILabel!
    @IBOutlet private weak var authorDescription: UILabel!
    @IBOutlet private weak var authorBio: UIButton!
    @IBOutlet private weak var authorFb: UIButton!
    @IBOutlet private weak var authorTwitter: UIButton!
    @IBOutlet private weak var authorGooglePlus: UIButton!
    @IBOutlet private weak var feed: UIButton!
    
    var authorData: Authors?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        self.title = "Author Profile"
        uiSetUp()
    }
    
    private func uiSetUp() {
        if let imageUrl = authorData?.photo, !imageUrl.isEmpty {
            Constants.shared.loadImage(imageView: profilePicture, imageUrl: imageUrl)
        }
        profilePicture.makeRounded(false, .clear, true)
        authorName.text = authorData?.name
        authorTitle.text = authorData?.title
        authorEmail.text = authorData?.email
        authorPhone.text = authorData?.phone
        authorDescription.text = authorData?.descriptionShort
        authorBio.layer.cornerRadius = authorBio.frame.height / 2
        authorFb.layer.cornerRadius = authorFb.frame.height / 2
        authorTwitter.layer.cornerRadius = authorTwitter.frame.height / 2
        authorGooglePlus.layer.cornerRadius = authorGooglePlus.frame.height / 2
        feed.layer.cornerRadius = feed.frame.height / 2
    }
    
    @IBAction private func authorBioAction(_ sender: Any) {
        navigateToRespectiveProfile(path: authorData?.bio, title: "Biography")
    }
    @IBAction private func authorFBAction(_ sender: Any) {
        navigateToRespectiveProfile(path: authorData?.facebook, title: "Facebook Profile")
    }
    
    @IBAction private func authorTwitterAction(_ sender: Any) {
        navigateToRespectiveProfile(path: authorData?.twitter, title: "Twitter Profile")
    }
    
    @IBAction private func authorGooglePlusAction(_ sender: Any) {
        navigateToRespectiveProfile(path: authorData?.googleplus, title: "Google+ Profile")
    }
    
    @IBAction private func feedAction(_ sender: Any) {
        navigateToRespectiveProfile(path: authorData?.rss, title: "Feeds")
    }
    
    private func navigateToRespectiveProfile(path: String?, title: String) {
        if let urlPath = path, !urlPath.isEmpty {
            let targetController = DetailsOnWebController(nibName: "DetailsOnWebController", bundle: nil)
            targetController.path = urlPath
            targetController.navTitle = title
            navigationController?.pushViewController(targetController, animated: true)
        } else {
            self.showToast(message: "Something went wrong!")
        }
    }
}
