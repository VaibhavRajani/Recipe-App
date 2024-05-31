//
//  MealViewModel.swift
//  Recipe App
//
//  Created by Vaibhav Rajani on 5/30/24.
//

import Foundation
import Combine

class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var mealDetails: MealDetails?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showAlert = false

    private func handleError(error: Error) {
        errorMessage = error.localizedDescription
        showAlert = true  
    }
    
    var apiService = APIService()
    
    func loadMeals() {
        isLoading = true
        errorMessage = nil
        apiService.fetchMeals { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let meals):
                    self?.meals = meals
                case .failure(let error):
                    self?.handleError(error: error)
                }
            }
        }
    }
    
    func loadMealDetails(mealId: String) {
        isLoading = true
        errorMessage = nil
        apiService.fetchMealDetails(mealId: mealId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let mealDetails):
                    self?.mealDetails = mealDetails
                case .failure(let error):
                    self?.handleError(error: error)
                }
            }
        }
    }
    
}
