# Ecommerce Application with Clean Architecture
This ecommerce mobile app was made using flutter with the principles of clean architecture.

## Table of contents
- [Getting Started](#getting-started)
- [Architecture](#architecture)
- [Packages Used](#packages-used)
- [Features](#features)
- [Testing](#testing)

## Getting started
To get started with the app, follow these steps:

1. Clone the repository:

   ````bash
   git clone https://github.com/your-username/todo-app-clean-architecture.git
   ```

   ````
2. Navigate to the project directory:

   ````bash
   cd todo-app-clean-architecture
   ```

   ````
3. Install the dependencies:

   ````bash
   flutter pub get
   ```

   ````
4. Run the app:

   ````bash
   flutter run
   ```

## Architecture
This mobile application follows the principles of clean architecture by separating the UI, business logic and data.
1. **Presentation Layer**: This layer is responsible for displaying the UI and handling user input. It contains the app's screens, widgets, and the [BLoC](https://pub.dev/packages/flutter_bloc) for state management.

2. **Domain Layer**: This layer contains the business logic, entities and use cases for the app. It defines the entities, repositories, and interactors that represent the core functionality of the app. The domain layer is independent of the presentation and data layers.

3. **Data Layer**: This layer is responsible for retrieving and storing data. It includes implementations of repositories and data sources.

## Packages Used

These packages were used in this application:
- [intl](https://pub.dev/packages/intl): Provides internationalization and localization utilities.
- [equatable](https://pub.dev/packages/equatable): Provides value equality for Dart classes.
- [mockito](https://pub.dev/packages/mockito): Provides a mockito-based mock package for testing.
- [dartz](https://pub.dev/packages/dartz): Provides functional programming features such as Option and Either.
- [rxDart](https://pub.dev/packages/rxdart): Provides reactive programming features for Dart.

## Features

The app includes the following features:

- Add a new Product: Users can add new products by providing the image url, id, name, price, and .the product's description.
- View all Products: Users can see a list of all products with their information mentioned above.
- View a single Prodcut: Users can view the details of a specific product.
- Update a prduct: Users can update the any information of status of a product.
- Delete a product: Users can delete a prouct from the list.


## Testing
- Unit tests for core domain logic and repositories
- Unit tests for models and repositories in the data layer.

Run all tests:

   ````bash
   flutter test
   ````
