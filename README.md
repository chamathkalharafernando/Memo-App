# Memo App
## Overview
Memo App is a cross-platform mobile application built using Flutter and Dart for the frontend, with a Node.js and MongoDB backend. This app allows users to create, edit, and manage memos efficiently. It features a simple and intuitive UI and is designed to provide a seamless experience for users.

### Features
#####User Authentication: Sign up, log in, and manage user accounts.
##### Create and Edit Memos: Users can create, update, and delete memos.
##### Memo Categories: Organize memos into different categories for better management.
##### Cloud Storage: Memos are stored securely in a MongoDB database.
##### Real-time Synchronization: Ensures that memo updates are reflected across devices in real-time.
##### Responsive UI: Optimized for both Android and iOS platforms.
### Technologies Used
##### Flutter & Dart: For building the cross-platform mobile frontend.
##### Node.js: Backend server to handle API requests.
##### MongoDB: NoSQL database for storing user data and memos.
##### Express.js: For creating RESTful APIs.
##### JWT (JSON Web Tokens): For secure user authentication.
### Project Structure
Frontend (Flutter & Dart)
lib/: Contains the core Flutter code for the app.
screens/: All the app screens (Home, Login, Memo, etc.)
widgets/: Reusable UI components.
models/: Data models for memo structure.
services/: Services for handling API calls to the backend.
Backend (Node.js & MongoDB)
routes/: API endpoints for handling requests (e.g., memo creation, user authentication).
models/: MongoDB models for users and memos.
controllers/: Logic for processing requests and interacting with the database.
### Installation
#### Prerequisites
##### Flutter SDK: Install Flutter
##### Node.js: Install Node.js
##### MongoDB: Set up a MongoDB instance locally or use a cloud solution like MongoDB Atlas.
