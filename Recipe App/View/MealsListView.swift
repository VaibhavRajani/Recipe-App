//
//  MealsView.swift
//  Recipe App
//
//  Created by Vaibhav Rajani on 5/30/24.
//

import Foundation
import SwiftUI

struct MealsListView: View {
    @StateObject var viewModel = MealViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.meals) { meal in
                    NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                        MealRow(meal: meal)
                    }
                }
            }
            .navigationTitle(Strings.mealsListViewTitle)
            .onAppear {
                viewModel.loadMeals()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(Strings.errorTitle), message: Text(viewModel.errorMessage ?? Strings.unknownError), dismissButton: .default(Text(Strings.ok)))
        }
    }
}

struct MealRow: View {
    var meal: Meal

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                image.resizable()
            } placeholder: {
               Color.gray.frame(width: 50, height: 50)
            }
            .frame(width: 50, height: 50)
            .cornerRadius(25)

            VStack(alignment: .leading) {
                Text(meal.strMeal)
                    .font(.headline)
            }
        }
    }
}

struct MealsListView_Previews: PreviewProvider {
    static var previews: some View {
        MealsListView()
    }
}
