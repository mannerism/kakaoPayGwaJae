//
//  SearchViewController+SearchBarDelegateUnitTest.swift
//  AppUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//

import XCTest
@testable import KakaoPaySukHoYu

class SearchViewControllerSearchBarDelegateUnitTest: XCTestCase {
	var sut: SearchViewController!
	
	override func setUp() {
		super.setUp()
		sut = SearchViewController()
		sut.api = MockRestProcessor()
	}
	
	// MARK: - SearchViewController+SearchBarDelegate
	func testSearchBarSearchButtonClicked() {
		sut.viewDidLoad()
		let mock = MockRestProcessor()
		sut.api = mock
		let searchBar = UISearchBar()
		searchBar.text = "testString"
		sut.searchBarSearchButtonClicked(searchBar)
		XCTAssertTrue(mock.didRunMakeRequest)
	}
	
	override func tearDown() {
		sut = nil
		super.tearDown()
	}
}
