# HNG Mobile Dev: Stage Four Task  - Malltiverse

---
![alt text](/gitfiles/screenshot1.png)

## Table of contents

- [Overview](#overview)
- [Task Requirement](#task-requirement)
- [Solution](#solution)
- [Screenshot](#screenshot)
- [Features](#features)
- [The process](#the-process)
  - [Built with](#built-with)
  - [Installation](#installation)
  - [Useful resources](#useful-resources)
- [API Integration](#api-integration)
- [UI/UX](#uiux)
- [Mobile Architecture](#mobile-architecture)
- [Future Improvements](#future-improvements)
- [APK Download](#apk-download)
- [Appitize Link](#appitize-link)
- [Author](#author)
- [Contributing](#contributing)
- [License](#license)

## Overview

This is a solution to the mobile dev stage four task of Implementating Timbu API and e-commerce design made by the product design team.

Objectives: add and complete features like the ability to add and remove products from cart, checkout the order. a simulated payment flow, order confirmation and an orders history Screen.

## Task Requirement

- All products must be fetched from the Timbu API. No Placeholder should be found in your app .
- Have at least 20 Unique Products in your product list. They should be categorized.
- Implement the feature of adding and removing products, wishlist or bookmark, checkout of order e.t.c based on your timbu shop design.
- Good shopping experience from start to the completion of an order.
- Create an Orders history screen i.e showing all the completed orders made on your timbu shop. Add an icon on your home screen top bar that navigates to the order history screen. Come up with the design if not available.
- The Orders history item when clicked must go to a details screen of that order and show details of that order.
- The items in the order history screen and details should be cached in a database.
- Proper UI state management and handle errors properly.
- Fix all noticeable issues.

## Solution

Maltivers is an eCommerce mobile app that specializes in selling various categories of product for men, women and tech. Customers can browse the available products and place orders directly from the app, and also view order history and details.

### Screenshot

![alt text](/gitfiles/screenshot2.png)
![alt text](/gitfiles/screenshot4.png)
![alt text](/gitfiles/screenshot5.png)
![alt text](/gitfiles/screenshot6.png)
![alt text](/gitfiles/screenshot7.png)
![alt text](/gitfiles/screenshot8.png)
![alt text](/gitfiles/screenshot9.png)

## Features

- Pull to Refresh: Allows users to refresh the product list by pulling down the screen.
- Complete shoppinng experience.
- Splash Screen: An initial loading screen with the app logo that navigates to the home screen after a delay.
- Product Listing: Displays a list of available products based on category.
- Cart Screen: Provides detailed information about each product, user has included in cart and they can remove, add or reduce a given product, items are locally stored to ensure persistency of data.
- Checkout Screen: Users can select the medium of delivery and they are required to input a contact information.
- Payment Screen: Users can enter their card details to make payment, the card edit as the user types the card detail.
- Confirmation dialogue: to ensure  the user is willing and ready to make  order.
- Order History: An order history screen where users can view orders and delete orders by swiping.
- Order Detail: An order detail screen where users can see details of specific orders.

## The process

### Built with

- Flutter and Dart

### What I learnt

Developing the malltiverse app provided several valuable insights and lessons, both technical and non-technical, these lessons are summarized in the following bullet point:

- Understanding API Integration
Integrating the Timbu API required a deep understanding of API documentation and handling secure data. Using environment variables for sensitive information like API keys and organization IDs is crucial to maintaining security.
- State Management
Implementing state management with the Provider package in Flutter was essential for maintaining and updating the app's state efficiently. This pattern helped in separating the business logic from the UI, making the code more maintainable and scalable.
- Effective UI/UX Design
Creating a user-friendly interface involved using various Flutter widgets to provide a smooth and responsive experience. The pull-to-refresh feature and shimmer loading effect were particularly effective in improving the user experience by providing visual feedback during data loading.
- MVVM Architecture
Adopting the MVVM architecture pattern was a significant step in organizing the codebase. This architecture facilitated a clear separation of concerns, making the app easier to manage and extend.
- Async Programming
Handling asynchronous operations, such as fetching data from the API, was critical. Understanding Dart's async and await keywords and effectively managing loading states and error handling improved the app's robustness.

## Installation

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Android Studio or Visual Studio Code: Recommended for development and testing
- A device or emulator to run the app

### Setup Instructions

1.**Clone the repository**

   ```bash
   git clone https://github.com/yourusername/malltiverse.git
   ```
  
2.**Navigate to the project directory**

 ```bash
   cd malltiverse
   ```

3.**Get the required dependencies**

   ```bash
   flutter pub get
   ```

4.**Run the app**

  ```bash
   flutter run
   ```

### Useful resources

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Also check out these links to start your first flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

## API Integration

Malltiverse integrates with Timbu, a business management software that helps automate and simplify business operations. It allows managing invoices, debts, customer outreach, and more.

- API Documentation: [Timbu API Docs](https://docs.timbu.cloud/api/intro)
- Website: [Timbu](timbu.cloud)

To use the Timbu API, you need to obtain the following parameters:

- organization_id: Your organization ID
- myAppId: Your application ID
- myApiKey: Your API key

These parameters should be stored securely for security reasons and replaced with my own, which is AppUrl class in the constant folder.

## UI/UX

Spicey provides an intuitive and user-friendly interface:

- Splash Screen: Displays an icon and app name while initializing.
- Home Screen: Lists products with a pull-to-refresh feature and shimmer loading effect.
- Detail Screen: Shows detailed information about each product, including images, descriptions, and prices, with options to add/remove from cart and place an order.

## Mobile Architecture

Malltiverse follows the MVVM (Model-View-ViewModel) architecture pattern, which separates the business logic from the UI. This architecture enhances code maintainability and testability.

Code Structure:

- Models: Defines the data structures used in the app.
- ViewModels (Providers): Manages the app's data and business logic.
- Views: Contains the UI components and screens.

## Future Improvements

- Enhanced Error Handling: Improving error handling mechanisms to provide more informative feedback to the users and developers.
- Testing: Incorporating unit and integration tests to ensure the app's reliability and catch potential issues early.
- Performance Optimization: Optimizing the app's performance, particularly in handling large datasets and images, to ensure a smooth user experience.
- User Feedback: Gathering user feedback and iterating on the app's features and design based on real-world usage.
- Scalability: Preparing the app for scalability to handle more products, users, and potential new features in the future.

## APK Download

Download the latest version of the app from the link below:

[Download APK](https://drive.google.com/file/d/1aQ1_cS15nVeg-XjGPtP3sb56Ph5sf5KS/view?usp=sharing)
or
Download [here](/gitfiles/spicey.apk)

## Appitize Link

Try Spicey Demo: [Appitize.io](https://appetize.io/app/b_lvhmlpm4wge55ebyat2fgni65e)

## Author

- Uma Godwin Eke

- Linkedin - [@godwinekeuma](https://www.linkedin.com/in/godwinekeuma)
- Email - [godwinekeuma@gmail.com](https://www.frontendmentor.io/profile/yourusername)
- Twitter - [@godwinekeuma](https://www.twitter.com/godwinekeuma)

## Contributing

Contributions are welcome! If you'd like to contribute, please follow these steps:

1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature-name`
3. Make your changes
4. Commit your changes: `git commit -m 'Add some feature'`
5. Push to the branch: `git push origin feature/your-feature-name`
6. Submit a pull request

Please ensure your code adheres to the existing code style and includes appropriate tests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
