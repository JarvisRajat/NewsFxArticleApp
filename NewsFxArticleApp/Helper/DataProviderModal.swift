//
//  DataProviderModal.swift
//  NewsFxArticleApp
//
//  Created by Rajat Raj on 24/12/21.
//

import Foundation
struct FxArticleRuleEngine: Codable {
    let breakingNews: [BreakingNewsData]?
    let topNews: [Data]?
    let dailyBriefings: DailyBriefingData?
    let technicalAnalysis: [Data]?
    let specialReport: [Data]?
}
struct BreakingNewsData: Codable {}
struct Data: Codable {
    let title: String?
    let url: String?
    let description: String?
    let content: String?
    let firstImageUrl: String?
    let headlineImageUrl: String?
    let backgroundImageUrl: String?
    let videoType: String?
    let videoId: String?
    let videoUrl: String?
    let videoThumbnail: String?
    let newsKeywords: String?
    let authors: [Authors]?
    let instruments: [String]?
    let tags: [String]?
    let categories: [String]?
    let displayTimestamp: Int?
    let lastUpdatedTimestamp: Int?
}
struct Authors: Codable {
    let name: String?
    let title: String?
    let bio: String?
    let email: String?
    let phone: String?
    let facebook: String?
    let twitter: String?
    let googleplus: String?
    let subscription: String?
    let rss: String?
    let descriptionLong: String?
    let descriptionShort: String?
    let photo: String?
}

struct DailyBriefingData: Codable {
    let eu: [Data]?
    let asia: [Data]?
    let  us: [Data]?
}
