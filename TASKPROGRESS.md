# Task Progress for Ecommerce App
A Flutter Mobile Application built for the 2024 A2SV Summer Internship in the mobile team.

## Table of contents
- [Task 6](#task-6)
- [Task 7](#task-7)
- [Task 8](#task-8)
- [Task 9](#task-9)
- [Task 10](#task-10)
- [Task 11](#task-11)
- [Task 12](#task-12)
- [Task 13](#task-13)
- [Task 14](#task-14)
- [Task 15](#task-15)
- [Task 16](#task-16)
- [Task 17](#task-17)
- [Task 18](#task-18)
- [Task 19](#task-19)
- [Task 20](#task-20)
- [Task 21](#task-21)
- [Task 22](#task-22)

## Task 6
### Implementing a Flutter User Interface

### Objective: 
- Create a Flutter user interface that replicates the design of a provided picture.

### Task: 
- You are tasked with implementing a user interface in Flutter that replicates the design of the provided picture. The picture will serve as a reference for the visual appearance and layout of the user interface you need to create.

### Figma Link: [Link]([url](https://www.figma.com/file/957Md2CrZ2B9KGjHy8RDcH/Internship?type=design&node-id=1%3A48&mode=design&t=dGzOJNr9pjkmYQog-1))

### Tasks Progress
- Home Page ✔️
- Details Page ✔️
- Add/Update Page ✔️
- Search Page ✔️
  
### Screenshots
#### Authentication
|-------------------------------------------|
| Splash Screen | Login Page | Register Page|
|---------------|------------|--------------|
|---------------|------------|-------|------|
|![Splash](https://github.com/user-attachments/assets/6d445f94-8208-4fff-b669-83f8a7982db4)|![Login](https://github.com/user-attachments/assets/7cd4b622-f4cc-4f2f-926f-d7ddb684da77)|![Register-1](https://github.com/user-attachments/assets/9a2ad953-e034-46c2-a05f-4e2fbf6f61e4)| ![Register-2](https://github.com/user-attachments/assets/15525c91-4094-4ce7-a5c6-8cd015350723)|

#### Product 
|-----------------------------------------------|
| Home page| Details Page| Add Page| Update Page| Search Page|
|-------------------------------------------------------------|
|![Home](https://github.com/user-attachments/assets/004e23d8-6be1-4ea8-8412-cf8f22cb8b7b)|![Details](https://github.com/user-attachments/assets/5e419300-ce36-4591-889d-cfdeb39ad02e)|![Add-1](https://github.com/user-attachments/assets/f1d402ea-4415-4e51-b82a-c6367c36f298)|![Add-2](https://github.com/user-attachments/assets/bdce1b9e-09d0-4558-8573-f82abccbae96)|![Update](https://github.com/user-attachments/assets/ec12a423-be66-42ec-87c3-205c42fd5ae7)|![image](https://github.com/user-attachments/assets/d53534ad-3a73-413a-9005-c742a4d04e29)|![image](https://github.com/user-attachments/assets/f446ae93-98d2-46db-9b55-d6275e3ae538)|
|-------------------------------------------------------------------|

## Task 7
### Implementing Navigation and Routing in a ecommerce Mobile App
You have been tasked with building a simple ecommerce mobile app using Flutter. The app should allow users to create, view, update and delete products. As part of this project, you are required to implement navigation and routing features to ensure a seamless user experience.

1. ✔️Screen Navigation: (3 points)
The app should have the following screens:
- A home screen that displays a list of all the products.
- A screen to add/edit a new product.
- A screen to view an existing product when selected from the list.
- Implement navigation between these screens using Flutter's built-in navigation methods.
2. ✔️Named Routes: (1 point)
- Define named routes for each screen in the app. Utilize named routes to navigate between screens rather than using anonymous routes.
3. ✔️Passing Data Between Screens: (3 points)
- When adding or editing a product, allow the user to input the product's title and description. 
- Pass the product data from the home screen to the add/edit product screens and back to the home screen when the product is created or updated.
4. ✔️Navigation Animations: (2 points)
- Implement smooth navigation animations and transitions between screens to enhance the user experience. 
5. ✔️Handling Navigation Events: (1 point)
- When the user presses the back button from the add/edit product screen, ensure the app navigates back to the home screen. Handle any other necessary navigation events appropriately. 

## Task 8
### ✔️Setting Up Linter Rules in Flutter
The primary objective of this task is to set up good linter rules in your Flutter project. Linter rules help maintain code quality, readability, and consistency across your project, making it easier to collaborate and scale.

### Deliverables
1. ✔️A Flutter project (ecommerce_app) with linter rules set up and configured. 

## Task 9
### Entities, Use Cases, and Repositories
In this task, we will build upon the existing eCommerce Mobile App using the knowledge gained from the TDD Clean Architecture Course. We will implement CRUD (Create, Read, Update, Delete) operations for products while adhering to Clean Architecture principles and employing Test-Driven Development (TDD) practices.
### Task Objectives
- Create entities for the products in the eCommerce Mobile App.
- Define use cases for inserting, updating, deleting, and getting a product.
- Implement repositories to handle data operations for the products.
### Task Progress
Make sure to also include tests for these. 
- ✔️Entities:
  - Define a Product entity with properties such as id, name, description, price and imageUrl. 
- ✔️Use Cases:
  - ✔️Define use cases for each of the CRUD operations.
    - InsertProduct: A use case for adding a new product. 
    - UpdateProduct: A use case for updating an existing product. 
    - DeleteProduct: A use case for removing a product. 
    - GetProduct: A use case for retrieving the details of a product. 
    - GetAllProducts: A use case for retrieving all products. 
- Repositories:
  - Implement a ProductRepository that uses the defined use cases to perform CRUD operations on the Product entity. 

## Task 10
### Data Overview Layer
Flutter projects do not come with specific folders like `core` or `features`. These folder structures are part of the Clean Architecture pattern, which provides a way to organize code for better separation of concerns and maintainability.

1. ✔️Step 1: Folder Setup
  Organize the project structure according to Clean Architecture principles. Create the following folders in the `lib` directory:
  - `core`: Contains the shared core components, entities, and error handling logic. 
  - `features`: Includes feature-specific modules. 
  - `features/product`: This will be the main module for the Ecommerce feature. 
  - `test`: Contains all the unit and widget tests.

2. ✔️Step 2: Implement Models
  - Inside the `features/ecommerce/data/models` directory, create a `Product_model.dart` file.
  - Define the `ProductModel` class that mirrors the `Product` entity, and include conversion logic to and from JSON using `fromJson` and `toJson` methods.
  - Write unit tests for the `ProductModel` to ensure its correctness.

3. ✔️Step 3: Documentation
- Update the project documentation to include information about architecture, data flow.
- Ensure that the documentation is clear and comprehensive.
- Make sure that you write on github readme.md 

## Task 11
### Contracts of Data Sources
In this task, you will be applying the concepts learned from the provided learning material to create an Ecommerce app using Flutter. Your app 	will utilize the principles of contracts, repository dependencies, network information, local data sources, and setting up the repository. 
### Requirements
- ✔️Contract and Repository: 
  - Implement a contract that defines the methods a repository must  fulfill, similar to the approach described in the learning material.
- ✔️Create interfaces or abstract classes for repository dependencies, such as remote and local data sources.

## Task 12
### Implement Repository
In this task, you will be applying the concepts learned from the provided learning material to create an Ecommerce app using Flutter. Your app will utilize the principles of contracts, repository dependencies, local data sources, and setting up the repository. 
### Requirements:
- ✔️Contract and Repository:
- ✔️Set up a basic structure for your repository, and you're implementing all the logic at this stage for the repository contracts from the domain layer.
  - Use local datasource when network is unavailable 
  - Use remote datasource when network is available 

## Task 13
### Implement Network Info
The task involves adding enhancements to an existing Ecommerce mobile app. The app currently allows users to manage their tasks by adding, updating, and deleting items from their Ecommerce list. The objective is to introduce additional functionalities such as caching and network connectivity detection that enhance the user experience.
### Task Features and Enhancements
- ✔️Implement a NetworkInfo class and utilize it within the repository to ascertain the presence or absence of a network connection.

## Task 14
### Implement Local Data Source
In this task, you will be implementing a local datasource for the Ecommerce app. The local datasource will be useful when  the user is not connected to the internet and the app is forced to show cached items. It will be also useful to show temporary items while the app is loading products from a remote server.
### Requirements:
- ✔️Implement local datasource implementation that implements the ProductLocalDatasource interface(contract)
Use shared preference to store products locally

## Task 15
### Implement Remote Data Source
In this task, you will be implementing a remote datasource for the Ecommerce app. 
### Requirements:
- ✔️Implement remote datasource implementation that implements the ProductRemoteDatasource interface(contract)

## Task 16
### Improve Code Organization and Reusability
- ✔️In this task, you will enhance the code organization and reusability of the Ecommerce app. By following best practices, you will improve the maintainability and efficiency of the codebase.

## Task 17
### Implement Bloc
On this section you will continue working on continuing ecommerce app and add bloc to our app. 

1. ✔️Task 17.1: Create Event Classes
  Create the necessary Event classes for your ecommerce app. These events will represent different user actions that trigger changes in your app's state. Define the following event classes:

  - LoadAllProductEvent: This event should be dispatched when the user wants to load all products from the repository.
  - GetSingleProductEvent: Dispatch this event when the user wants to retrieve a single product using its ID.
  - UpdateProductEvent: Dispatch this event when the user wants to update a product's details.
  - DeleteProductEvent: Dispatch this event when the user wants to delete a product.
  - CreateProductEvent: Dispatch this event when the user wants to create a new product. 

2. ✔️Task 17.2: Create State Classes
  Design the State classes that will represent the various states of your app's UI. These states will guide your app's behavior based on user interactions and data updates. Implement the following state classes:

  - IntialState: Represents the initial state before any data is loaded.
  - LoadingState: Indicates that the app is currently fetching data.
  - LoadedAllProductState: Represents the state where all products are successfully loaded from the repository.
  - LoadedSingleProductState: Represents the state where a single product is successfully retrieved.
  - ErrorState: Indicates that an error has occurred during data retrieval or processing.

3. ✔️Task 17.3: Create ProductBloc
  Develop the product BLoC by creating a new class named product Bloc. This class will handle the business logic, event processing, and state management for your product app. Implement the following tasks within the productBloc:

  - Set up the initial state of the bloc to EmptyState.
  - Create the necessary methods to handle each event. For example, implement methods like mapEventToState to process events and return the corresponding states.
  - Implement the logic for each event, interacting with the provided use cases (getAllProduct, getSingleProduct, updateProduct, deleteProduct, createProduct) and transforming the states accordingly.
  - Utilize Streams to emit the appropriate states based on the logic and events processed.
  - Ensure proper error handling for events that could result in failures, and emit the ErrorState when necessary.
  - Make sure that the ProductBloc is properly injected into your app's components, and that you're using the bloc to manage the UI state effectively.


## Task 18
### Dependency Injection
Before we can create a UI, we need to connect the various components together. Each class in our project is decoupled from its dependencies by accepting them through its constructor, so we need a way to provide these dependencies. By using the get_it package in Flutter, we can manage dependency injection efficiently. This approach aligns with the principles of clean architecture, where the responsibility of creating objects is separated. It promotes better organization, testability, maintainability, and allows for easily swapping implementations when needed.

### Grading System
- ✔️Setup and configuration:
  - Correctly add the get_it package to the pubspec.yaml file.
  - Import the necessary get_it package in the injection container file.
- ✔️Creating the Injection Container:
  - Define a singleton instance of the GetIt service locator.
  - Register all necessary dependencies (e.g., repositories, services, and view models) with appropriate scope (e.g., singleton, factory).
  - Ensure that all dependencies are registered in the correct manner, respecting any necessary dependency chains. 

## Task 19
### ✔️ Implement User Interface

## Task 20
### Consume Bloc for eCommerce
In the process of building the user interface for the ecommerce app as part of the "Flutter TDD Clean Architecture Course - User Interface," your Product is to integrate and consume the Bloc pattern for various Product management functionalities. This will involve creating, retrieving all Products, and getting Product details.

### Product Objectives:
Demonstrate the ability to connect UI components with the Bloc pattern for state management.
Apply Clean Architecture principles to maintain separation of concerns and modularity.
Implement the required UI components and interaction to showcase the Product management functionalities.

### Products
- Create Product Page:
  - ✔️Design a screen that allows users to input product details and create a new product. 
  - ✔️Consume the appropriate bloc method to handle the product creation process.
  - ✔️Display feedback to the user based on the success or failure of the creation process.

- Retrieve All Products Page:
  - ✔️Design a screen that displays a list of all Products.
  - ✔️Consume the bloc method responsible for retrieving all products.
  - ✔️Implement UI components to display the list of products.

- Product Detail Page:
  - ✔️Design a screen that shows detailed information about a selected Product.
  - ✔️Consume the bloc method to fetch Product details based on the selected Product.
  - ✔️Display the Product title, description, due date, and status on the detail page.

- Edit Product Page:
  - ✔️Consume the appropriate bloc method to handle the product editing process.
  - ✔️Display feedback to the user based on the success or failure of the editing process.

- Delete Product Page:
  - ✔️Consume the appropriate bloc method to handle the product deletion process.
  - ✔️Display feedback to the user based on the success or failure of the deletion process.

- Navigation and Routing:
  - ✔️Set up proper navigation between the product-related pages (create product, all products, product detail).
  - ✔️Implement appropriate routing mechanisms to ensure a smooth user experience.

- Testing:
  - ✔️Write unit tests to ensure that UI components are correctly connected to the Bloc and reflect the expected behavior.
  - ✔️Verify that the UI responds appropriately to different states emitted by the Bloc.

- Code Cleanup and Refactoring:
  - ✔️Apply Clean Architecture principles to organize your code into presentation, domain, and data layers
  - ✔️Ensure that your code is readable, maintainable, and follows best practices

## Task 21
### Widget Testing
In this task, you will be adding widget tests to your existing ecommerce app user interface you built to ensure that the UI components and user interactions work correctly. Widget testing is essential to verify that your app's UI remains stable as you make changes or add new features.

### Task Steps:
1. Set up Widget Testing Environment 
  - ✔️Add the flutter_test package to your ecommerce app's pubspec.yaml file to enable widget testing.
  - ✔️Ensure your app is running in a test-friendly environment.

2. Test Product Creation 
  - ⚪Write a widget test to verify that new products can be created correctly in the ecommerce app.
  - ⚪Test the behavior of adding new products with different input scenarios, such as empty product names or valid product names.

3. Test Product Listing 
  - ⚪Write a widget test to ensure that the list of products is displayed correctly in the app's UI.
  - ⚪Verify that the list updates appropriately when new products are added or completed.

4. Test Product Detail Page Navigation 
  - ⚪Write a widget test to check if tapping the back button from the Product Detail page navigates to the main ecommerce list page correctly.

## Task 22
### Implement Authentication Feature
After two weeks of diligent work on the ecommerce app, the management team is pleased with the current product. The app now boasts a clean architecture and robust functionalities, but there is one crucial feature still missing: authentication.
To enhance security and user experience, the management team has requested that an authentication system be added to the app. We have already set up version 2 of the backend API, which only allows authenticated users to access the products API. Your task is to integrate this authentication system into the app, enabling users to register, log in, and securely manage their accounts.

### Task: 
You are tasked with replicating the designs for the splash screen, sign-in page, and sign-up page as specified in the provided Figma link. 
You should add the following to the ecommerce app:
#### ✔️An auth module following clean architecture principles just like the one for product module
#### Use cases:
  - ✔️Sign up
  - ✔️Login
  - ✔️Logout
#### Presentation layer should include
  - ✔️A splash screen that displays upon app launch.
  - ✔️A sign-in page for user authentication.
  - ✔️A sign-up page for user registration.
  - ✔️A home screen that displays the user's login/authentication status once logged in.
