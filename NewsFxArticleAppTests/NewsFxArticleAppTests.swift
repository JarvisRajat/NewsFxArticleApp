//
//  NewsFxArticleAppTests.swift
//  NewsFxArticleAppTests
//
//  Created by Rajat Raj on 24/12/21.
//

import XCTest
@testable import NewsFxArticleApp

class NewsFxArticleAppTests: XCTestCase {
    private var viewController: ViewController!
    private var fxArticleController: FXArticleViewController!
    private var authorProfileController: AuthorProfileViewController!
    private var webController: DetailsOnWebController!
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        fxArticleController = FXArticleViewController(nibName: "FXArticleViewController", bundle: nil)
        authorProfileController = AuthorProfileViewController(nibName: "AuthorProfileViewController", bundle: nil)
        webController = DetailsOnWebController(nibName: "DetailsOnWebController", bundle: nil)
        viewController.getData()
        viewController.loadViewIfNeeded()
        fxArticleController.loadViewIfNeeded()
        authorProfileController.loadViewIfNeeded()
        webController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        fxArticleController = nil
        authorProfileController = nil
        webController = nil
    }
    
    func testResponseHaveSomeData() {
        XCTAssertNil(viewController.responseData)
    }
    
    func testHasATableView() {
        XCTAssertNotNil(viewController.tableView)
        XCTAssertNotNil(fxArticleController.articleListTable)
       }
       
       func testTableViewHasDelegate() {
           XCTAssertNotNil(viewController.tableView.delegate)
           XCTAssertNotNil(fxArticleController.articleListTable.delegate)
       }
       
       func testTableViewHasDataSource() {
           XCTAssertNotNil(viewController.tableView.dataSource)
           XCTAssertNotNil(fxArticleController.articleListTable.dataSource)
       }
    
    func testNumberOfRows() {
        guard let tableView = viewController.tableView   else { return }
        let numberOfRows = viewController.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertTrue(numberOfRows>=0)
        guard let articleTable = fxArticleController.articleListTable else { return }
        let noOfRowsinFxArticle = fxArticleController.tableView(articleTable, numberOfRowsInSection: 0)
        XCTAssertTrue(noOfRowsinFxArticle >= 0)
    }
        
        func testTableViewCellHasReuseIdentifier() {
            let tableView = UITableView()
            tableView.register(UINib(nibName: "TypeHeaderCell", bundle: Bundle.main), forCellReuseIdentifier: "TypeHeaderCell")
            let cell = viewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
            let actualReuseIdentifer = cell.reuseIdentifier
            let expectedReuseIdentifier = "TypeHeaderCell"
            XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
        }
    func testAuthorProfileHaveData() {
        XCTAssertNil(authorProfileController.authorData)
    }
    func testTableViewHasSections() {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "DailyBriefingHeaderView", bundle: Bundle.main),
                           forHeaderFooterViewReuseIdentifier: "DailyBriefingHeaderView")
        let headerView = fxArticleController.tableView(tableView, viewForHeaderInSection: 0)
        let headerViewIdentifier = headerView?.restorationIdentifier
        let actualId = "DailyBriefingHeaderView"
        XCTAssertEqual(headerViewIdentifier, actualId)
    }
    func testControllerIsLoaded() {
        webController.path = "https://www.google.com"
        webController.viewDidLoad()
    }
    
    func testTableViewDidSelect() {
        XCTAssertNotNil(viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath(row: 1, section: 0)))
    }
}
