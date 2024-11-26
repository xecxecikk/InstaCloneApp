# InstaCloneApp

nstaCloneApp is a social media clone application developed in Swift using Firebase as the backend. The app leverages Swift Package Manager (SPM) for dependency management. It allows users to sign up, log in, log out, upload posts with images and comments, and interact with a feed of posts by liking or deleting them.

## Tools and Technologies Used

 - `Swift`: The programming language used for the development of the application.
 
 - `UIKit`: Framework used for building user interface components.
  
 - `UIViewController` `UITableView` `UITableView` and `UITextField`

 - ###### `Firebase`:
   
  - `FirebaseAuth`: Used for user authentication (sign in, sign up, log out).
  - `FirebaseFirestore`: Used for real-time database operations to store and retrieve post data (image URLs, comments, likes, etc.).
 -  `FirebaseStorage`:Used to upload and store images in the cloud.
 -  `SDWebImage`: For asynchronous image loading and caching.
 -  `Swift Package Manager (SPM)` : To manage external dependencies.
  - `Foundation`: To utilize Swift’s core functionalities for date, time, and string operations.

  
## Features

### 1. Authentication
Users can sign up and log in with their email and password using Firebase Authentication.
Users can log out using the logout button in the settings tab.

### 2. Upload Posts
Users can upload a photo from their device along with a comment. The photo is stored in Firebase Storage, and the post details are saved in Firebase Firestore.

### 3.Feed
Displays a list of posts in a table view, showing the image, user email, comments, and like counts.
Users can like posts, which updates the like count in real-time.
Users can delete their own posts after confirmation.

### 4. Logout
Users can log out from the app by navigating to the Settings tab and clicking the logout button.

### 4. Real-Time Updates
he app uses Firebase Firestore’s real-time listener to dynamically update the feed whenever a new post is added or an existing post is updated/deleted.


## Screenshots

### 1. Login Screen
Allows users to log in or navigate to the sign-up screen.

### 2.Upload Screen
Lets users select an image from their gallery, add a comment, and post it.

### 3.Feed Screen
Displays all posts in a table view with options to like or delete posts.

### 4. Settings Screen
Contains a logout button to log out from the app.


## Code Overview

### 1. ViewController - 
Handles user authentication (sign up, log in, and error handling).
Key Functions:
-  `signInClicked`: Authenticates a user using Firebase.
-  `signUpClicked`: Registers a new user and redirects to the main tab bar.
  
### 2.UploadViewController.swift
Manages uploading new posts.
Key Functions:
- `chooseImage`: Lets users select an image from their photo library.
- `actionButtonClicked`: Uploads the selected image to Firebase Storage, saves the post details (image URL, comment, etc.) in Firestore, and redirects to the Feed tab.
 
### 3.FeedViewController.swift
Handles the display of posts in a table view.
Key Functions:
- `getDataFromFirestore`: Fetches posts from Firebase Firestore, ordered by date, and updates the table view.
- `tableView(_:cellForRowAt:)`: Configures each cell in the feed, including loading the post image using SDWebImage.

### 4.FeedViewController.swift
Custom table view cell for displaying post details.
Key Features:
- `likeButtonClicked`: Increments the like count for the post in Firebase
- `deleteButtonClicked`: Deletes the post after user confirmation.

### 5.SettingsViewController.swift
Handles user logout functionality.
Key Function:
- `logOutClicked`:  Logs out the user using Firebase Authentication and redirects to the login screen.

## Dependencies
 `Firebase`: Backend services for authentication, Firestore (database), and Storage.
 `SDWebImage`: Handles image caching and asynchronous loading.

## Setup Instructions
#### Prerequisites
Install Xcode (version 14.0 or later recommended).
Create a Firebase project and configure Firebase for the iOS app:
- Download GoogleService-Info.plist from Firebase Console and add it to your project.
Install dependencies using **


https://github.com/user-attachments/assets/825b7f32-82fa-4c7e-aa9d-c0bbb776d0b6







