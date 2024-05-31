//
//  Meal.swift
//  Recipe App
//
//  Created by Vaibhav Rajani on 5/30/24.
//

import Foundation

struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String

    var id: String { idMeal }
}

struct MealsResponse: Codable {
    let meals: [Meal]
}
