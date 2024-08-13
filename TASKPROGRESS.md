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
#### Home Page
- ![image](https://github.com/user-attachments/assets/4c902287-db27-4b37-b043-41a2f1804ace)

#### Details Page
- ![image](https://github.com/user-attachments/assets/c712be2c-2fb7-46d8-9900-538f04089b06)
- ![image](https://github.com/user-attachments/assets/d1284ec6-6056-4a33-84fb-e6d3f2efbc67)

#### Add/Update Page
- ![image](https://github.com/user-attachments/assets/d11cf34f-f949-490d-9559-3c247ff2ec1a)
- ![image](https://github.com/user-attachments/assets/12a48067-5442-417c-91d4-9dfb221ceaf1)

#### Search Page
- ![image](https://github.com/user-attachments/assets/d53534ad-3a73-413a-9005-c742a4d04e29)
- ![image](https://github.com/user-attachments/assets/f446ae93-98d2-46db-9b55-d6275e3ae538)

## Task 7
### Implementing Navigation and Routing in a ecommerce Mobile App
You have been tasked with building a simple ecommerce mobile app using Flutter. The app should allow users to create, view, update and delete products. As part of this project, you are required to implement navigation and routing features to ensure a seamless user experience.

1. Screen Navigation: (3 points)
The app should have the following screens:
- A home screen that displays a list of all the products. ✔️
- A screen to add/edit a new product. ✔️
- A screen to view an existing product when selected from the list. ✔️
- Implement navigation between these screens using Flutter's built-in navigation methods. ✔️
2. Named Routes: (1 point)
- Define named routes for each screen in the app. Utilize named routes to navigate between screens rather than using anonymous routes. ✔️
3. Passing Data Between Screens: (3 points)
- When adding or editing a product, allow the user to input the product's title and description. ✔️
- Pass the product data from the home screen to the add/edit product screens and back to the home screen when the product is created or updated. ✔️
4. Navigation Animations: (2 points)
- Implement smooth navigation animations and transitions between screens to enhance the user experience. ✔️
5. Handling Navigation Events: (1 point)
- When the user presses the back button from the add/edit product screen, ensure the app navigates back to the home screen. Handle any other necessary navigation events appropriately. ✔️

## Task 8
### Setting Up Linter Rules in Flutter
The primary objective of this task is to set up good linter rules in your Flutter project. Linter rules help maintain code quality, readability, and consistency across your project, making it easier to collaborate and scale.

### Deliverables
1. A Flutter project (ecommerce_app) with linter rules set up and configured. ✔️

## Task 9
### Entities, Use Cases, and Repositories
In this task, we will build upon the existing eCommerce Mobile App using the knowledge gained from the TDD Clean Architecture Course. We will implement CRUD (Create, Read, Update, Delete) operations for products while adhering to Clean Architecture principles and employing Test-Driven Development (TDD) practices.
### Task Objectives
- Create entities for the products in the eCommerce Mobile App.
- Define use cases for inserting, updating, deleting, and getting a product.
- Implement repositories to handle data operations for the products.
### Task Progress
Make sure to also include tests for these. ✔️
- Entities:
  - Define a Product entity with properties such as id, name, description, price and imageUrl. ✔️
- Use Cases:
  - Define use cases for each of the CRUD operations
    - InsertProduct: A use case for adding a new product. ✔️
    - UpdateProduct: A use case for updating an existing product. ✔️
    - DeleteProduct: A use case for removing a product. ✔️
    - GetProduct: A use case for retrieving the details of a product. ✔️
    - GetAllProducts: A use case for retrieving all products. ✔️
- Repositories:
  - Implement a ProductRepository that uses the defined use cases to perform CRUD operations on the Product entity. ✔️

## Task 10
### Data Overview Layer
Flutter projects do not come with specific folders like `core` or `features`. These folder structures are part of the Clean Architecture pattern, which provides a way to organize code for better separation of concerns and maintainability.

1. Step 1: Folder Setup
  Organize the project structure according to Clean Architecture principles. Create the following folders in the `lib` directory:
  - `core`: Contains the shared core components, entities, and error handling logic. ✔️
  - `features`: Includes feature-specific modules. ✔️
  - `features/product`: This will be the main module for the Ecommerce feature. ✔️
  - `test`: Contains all the unit and widget tests. ✔️

2. Step 2: Implement Models
  - Inside the `features/ecommerce/data/models` directory, create a `Product_model.dart` file. ✔️
  - Define the `ProductModel` class that mirrors the `Product` entity, and include conversion logic to and from JSON using `fromJson` and `toJson` methods. ✔️
  - Write unit tests for the `ProductModel` to ensure its correctness. ✔️

3. Step 3: Documentation
- Update the project documentation to include information about architecture, data flow. ✔️
- Ensure that the documentation is clear and comprehensive. ✔️
- Make sure that you write on github readme.md ✔️

## Task 11
### Contracts of Data Sources
In this task, you will be applying the concepts learned from the provided learning material to create an Ecommerce app using Flutter. Your app 	will utilize the principles of contracts, repository dependencies, network information, local data sources, and setting up the repository. 
### Requirements
- Contract and Repository: ✔️
  - Implement a contract that defines the methods a repository must  fulfill, similar to the approach described in the learning material. ✔️
- Create interfaces or abstract classes for repository dependencies, such as remote and local data sources. ✔️

## Task 12
### Implement Repository
In this task, you will be applying the concepts learned from the provided learning material to create an Ecommerce app using Flutter. Your app will utilize the principles of contracts, repository dependencies, local data sources, and setting up the repository. 
### Requirements:
- Contract and Repository:
- Set up a basic structure for your repository, and you're implementing all the logic at this stage for the repository contracts from the domain layer. ✔️
  - Use local datasource when network is unavailable ✔️
  - Use remote datasource when network is available ✔️

## Task 13
### Implement Network Info
The task involves adding enhancements to an existing Ecommerce mobile app. The app currently allows users to manage their tasks by adding, updating, and deleting items from their Ecommerce list. The objective is to introduce additional functionalities such as caching and network connectivity detection that enhance the user experience.
### Task Features and Enhancements
- Implement a NetworkInfo class and utilize it within the repository to ascertain the presence or absence of a network connection. ✔️

## Task 14
### Implement Local Data Source
In this task, you will be implementing a local datasource for the Ecommerce app. The local datasource will be useful when  the user is not connected to the internet and the app is forced to show cached items. It will be also useful to show temporary items while the app is loading products from a remote server.
### Requirements:
- Implement local datasource implementation that implements the ProductLocalDatasource interface(contract)
Use shared preference to store products locally ✔️

## Task 15
### Implement Remote Data Source
In this task, you will be implementing a remote datasource for the Ecommerce app. 
### Requirements:
- Implement remote datasource implementation that implements the ProductRemoteDatasource interface(contract) ✔️

## Task 16
### Improve Code Organization and Reusability
- In this task, you will enhance the code organization and reusability of the Ecommerce app. By following best practices, you will improve the maintainability and efficiency of the codebase. [In-Progress]
