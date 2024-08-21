# Ecommerce Application with Clean Architecture
This ecommerce mobile app was made using flutter with the principles of clean architecture.

## Table of contents
- [Getting Started](#getting-started)
- [Architecture](#architecture)
- [Packages Used](#packages-used)
- [Features](#features)
- [Screenshots](#screenshots)
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

2. **Domain Layer**: This layer contains the business logic and use cases for the app. It defines the entities, repositories, and interactors that represent the core functionality of the app. The domain layer is independent of the presentation and data layers.

3. **Data Layer**: This layer is responsible for retrieving and storing data. It includes implementations of repositories and data sources. In this app, the [shared_preferences](https://pub.dev/packages/shared_preferences) package is used as the local data source.

## Packages Used

These packages were used in this application:
- [flutter_bloc](https://pub.dev/packages/flutter_bloc): State management library based on the BLoC (Business Logic Component) pattern.
- [shared_preferences](https://pub.dev/packages/shared_preferences): Provides a persistent key-value store for storing data locally.
- [uuid](https://pub.dev/packages/uuid): Generates unique IDs for tasks.
- [intl](https://pub.dev/packages/intl): Provides internationalization and localization utilities.
- [equatable](https://pub.dev/packages/equatable): Provides value equality for Dart classes.
- [mockito](https://pub.dev/packages/mockito): Provides a mockito-based mock package for testing.
- [dartz](https://pub.dev/packages/dartz): Provides functional programming features such as Option and Either.
- [rxDart](https://pub.dev/packages/rxdart): Provides reactive programming features for Dart.
## Features

The app includes the following features:

- Sign up/Register a user: Users can register themselves by providing name, email and password.
- Login/Signin a user: Users can login using their email and password.
- Add a new Product: Users can add new products by providing the image url, id, name, price, and .the product's description.
- View all Products: Users can see a list of all products with their information mentioned above.
- View a single Prodcut: Users can view the details of a specific product.
- Update a prduct: Users can update the any information of status of a product.
- Delete a product: Users can delete a prouct from the list.

## Screenshots
### Authentication

| Splash Screen | Login Page | Register Page| Register Page-2 |
|---------------|------------|--------------|-----------------|
|![Splash](https://github.com/user-attachments/assets/6d445f94-8208-4fff-b669-83f8a7982db4)|![Login](https://github.com/user-attachments/assets/7cd4b622-f4cc-4f2f-926f-d7ddb684da77)|![Register-1](https://github.com/user-attachments/assets/9a2ad953-e034-46c2-a05f-4e2fbf6f61e4)| ![Register-2](https://github.com/user-attachments/assets/15525c91-4094-4ce7-a5c6-8cd015350723)|

### Product 

| Home page| Details Page| Add Page| Add Page-2|
|----------|-------------|---------|-----------|
|![Home](https://github.com/user-attachments/assets/004e23d8-6be1-4ea8-8412-cf8f22cb8b7b)|![Details](https://github.com/user-attachments/assets/5e419300-ce36-4591-889d-cfdeb39ad02e)|![Add-1](https://github.com/user-attachments/assets/f1d402ea-4415-4e51-b82a-c6367c36f298)|![Add-2](https://github.com/user-attachments/assets/bdce1b9e-09d0-4558-8573-f82abccbae96)|

|Update Page| Search Page| Search|
|-----------|------------|-------|
|![Update](https://github.com/user-attachments/assets/ec12a423-be66-42ec-87c3-205c42fd5ae7)|![Search-1](https://github.com/user-attachments/assets/d53534ad-3a73-413a-9005-c742a4d04e29)|![Search-2](https://github.com/user-attachments/assets/f446ae93-98d2-46db-9b55-d6275e3ae538)|

## Testing
- Unit tests for core domain logic and repositories
- Unit tests for models and repositories in the data layer.

Run all tests:

   ````bash
   flutter test
   ````
