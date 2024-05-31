//
//  MealViewModelTests.swift
//  Recipe AppTests
//
//  Created by Vaibhav Rajani on 5/31/24.
//

import Foundation
import XCTest
@testable import Recipe_App

class MockAPIService: APIService {
    var mealsData: Result<[Meal], Error>?
    
    override func fetchMeals(completion: @escaping (Result<[Meal], Error>) -> Void) {
        if let data = mealsData {
            completion(data)
        }
    }
    
    
}

class MealViewModelTests: XCTestCase {
    var viewModel: MealViewModel!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = MealViewModel()
        viewModel.apiService = mockAPIService
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testLoadMealsSuccess() {
        let meals = [Meal(idMeal: "52977", strMeal: "Apple & Blackberry Crumble", strMealThumb: "https://someurl.com/image.jpg")]
        mockAPIService.mealsData = .success(meals)
        
        viewModel.loadMeals()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.meals.count, 1)
        XCTAssertEqual(viewModel.meals.first?.strMeal, "Apple & Blackberry Crumble")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testLoadMealsFailure() {
        let error = NSError(domain: "APIError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data"])
        mockAPIService.mealsData = .failure(error)
        
        viewModel.loadMeals()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.errorMessage, "Failed to fetch data")
    }
    
}
