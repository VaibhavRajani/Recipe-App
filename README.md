# Recipe App

## Project Overview

The Recipe App is a native iOS application designed to allow users to browse through a collection of dessert recipes. Utilizing the Meal DB API, the app fetches and displays a list of meals in the dessert category, which users can explore to see detailed views including meal names, instructions, and ingredients. The app employs the MVVM architectural pattern to ensure clean separation of concerns and enhance maintainability.

## Code Structure and Details

### 1. **File Structure and Key Components**

- **Utilities**
  - **Strings.swift**: Contains all the static string constants used throughout the app, ensuring consistency and easing localization efforts.

- **Service**
  - **APIService.swift**: Manages all network requests, including fetching the list of meals and meal details. Uses generic methods to handle API calls, parsing JSON responses into model structures.

- **ViewModel**
  - **MealViewModel.swift**: Provides a bridge between the views and the service layer, managing the state of the UI elements and the data from API responses. It also handles error presentation using SwiftUI's alert mechanisms.

- **Views**
  - **MealsListView.swift** and **MealDetailView.swift**: SwiftUI views that present the list of meals and the detailed information of a selected B>meal, respectively.

- **Models**
  - **Meal.swift** and **MealDetails.swift**: Define the structure of the API data related to meals. MealDetails includes dynamic decoding to handle ingredients and measurements, filtering out any null or empty values in line with project guidelines.

### 2. **MVVM Architecture**

- The project adheres to the Model-View-ViewModel (MVVM) pattern:
  - **Model**: Manages the data logic (Meal and MealDetails).
  - **View**: Manages the presentation layer (MealsListView and MealDetailView).
  - **ViewModel**: Manages the business logic as an intermediary (MealViewModel).

### 3. **Network Error Handling**

- Defined within `APIService`, leveraging an enum `NetworkError` to handle various error scenarios, ensuring robust error management across network requests.

### 4. **Unit Testing**

- Example unit tests have been provided to ensure functionality works as expected and to facilitate maintenance and future updates without regressions.
