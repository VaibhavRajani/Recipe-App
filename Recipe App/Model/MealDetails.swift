//
//  MealDetails.swift
//  Recipe App
//
//  Created by Vaibhav Rajani on 5/30/24.
//

import Foundation

struct MealDetails: Decodable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    let strSource: String?
    
    var ingredients: [(ingredient: String, measure: String)] = []

    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb, strSource
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strSource = try container.decodeIfPresent(String.self, forKey: .strSource)

        let additionalKeys = try decoder.container(keyedBy: DynamicCodingKey.self)
        var ingredientsArray: [(ingredient: String, measure: String)] = []

        for i in 1...20 {
            let ingredientKey = DynamicCodingKey(stringValue: "strIngredient\(i)")
            let measureKey = DynamicCodingKey(stringValue: "strMeasure\(i)")
            
            if let ingredientKey = ingredientKey, let measureKey = measureKey,
               let ingredient = try additionalKeys.decodeIfPresent(String.self, forKey: ingredientKey),
               let measure = try additionalKeys.decodeIfPresent(String.self, forKey: measureKey),
               !ingredient.isEmpty {
                ingredientsArray.append((ingredient, measure))
            }
        }
        
        self.ingredients = ingredientsArray
    }
    
    struct DynamicCodingKey: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
    }
}


struct MealDetailResponse: Decodable {
    let meals: [MealDetails]
}
