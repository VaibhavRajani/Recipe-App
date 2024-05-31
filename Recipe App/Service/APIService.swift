//
//  APIService.swift
//  Recipe App
//
//  Created by Vaibhav Rajani on 5/30/24.
//
//

import Foundation

class APIService {
    private let baseUrl = "https://themealdb.com/api/json/v1/1"

    private func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchMeals(completion: @escaping (Result<[Meal], Error>) -> Void) {
        let urlString = "\(baseUrl)/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
                        completion(.failure(NetworkError.badUrl))
                        return
                    }
        
        fetch(url: url) { (result: Result<MealsResponse, Error>) in
            switch result {
            case .success(let mealsResponse):
                completion(.success(mealsResponse.meals))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMealDetails(mealId: String, completion: @escaping (Result<MealDetails, Error>) -> Void) {
        let urlString = "\(baseUrl)/lookup.php?i=\(mealId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.badUrl))
            return
        }
        
        fetch(url: url) { (result: Result<MealDetailResponse, Error>) in
            switch result {
            case .success(let mealDetailResponse):
                if let mealDetails = mealDetailResponse.meals.first {
                    completion(.success(mealDetails))
                } else {
                    completion(.failure(NetworkError.itemNotFound))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum NetworkError: Error {
    case badUrl
    case noData
    case itemNotFound
    case other(Error)
}
