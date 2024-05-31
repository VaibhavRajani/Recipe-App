//
//  MealDetailView.swift
//  Recipe App
//
//  Created by Vaibhav Rajani on 5/30/24.
//

import Foundation
import SwiftUI

struct MealDetailView: View {
    let mealId: String
    
    @ObservedObject var viewModel = MealViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let mealDetails = viewModel.mealDetails {
                    AsyncImage(url: URL(string: mealDetails.strMealThumb)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.frame(width: 100, height: 100)
                    }
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    
                    Text(mealDetails.strMeal)
                        .font(.title)
                        .fontWeight(.bold)

                    Text(Strings.instructionsTitle)
                        .font(.headline)

                    Text(mealDetails.strInstructions)
                        .font(.body)
                        .padding(.bottom)

                    Text(Strings.ingredientsTitle)
                        .font(.headline)

                    ForEach(viewModel.mealDetails?.ingredients ?? [], id: \.ingredient) { ingredient, measurement in
                        HStack {
                            Text("\(ingredient) - \(measurement)")
                                .padding(.vertical, 2)
                        }
                    }

                } else {
                    Text(Strings.loading)
                        .padding()
                }
            }
            .padding()
        }
        .navigationTitle(Strings.mealDetailsTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadMealDetails(mealId: mealId)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(Strings.errorTitle), message: Text(viewModel.errorMessage ?? Strings.unknownError), dismissButton: .default(Text(Strings.ok)))
             }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(mealId: "52970")
    }
}
